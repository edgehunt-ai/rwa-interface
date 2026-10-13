import { appendFile, mkdir, readFile, writeFile } from 'node:fs/promises';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';

export const scenarioIds = [
  'home_load', 'markets_load', 'markets_scroll', 'details_load',
  ...['buy', 'sell'].flatMap((side) => ['market', 'limit'].flatMap((type) => [
    ...['open_ready', 'open_settled', 'quote', 'preview', 'submit'].map((stage) => `${type}_${side}_${stage}`),
    ...(type === 'limit' ? [`${type}_${side}_cancel`] : []),
  ])),
];

export function percentile(values, p) {
  if (!values.length) throw new Error('Empty sample distribution');
  const sorted = [...values].sort((a, b) => a - b);
  return sorted[Math.max(0, Math.ceil(sorted.length * p) - 1)];
}

function distribution(values, label) {
  if (!Array.isArray(values) || !values.length || values.some((v) => !Number.isFinite(v) || v < 0)) {
    throw new Error(`Invalid samples: ${label}`);
  }
  return { count: values.length, p50: percentile(values, .5), p95: percentile(values, .95), max: Math.max(...values) };
}

function compatibility(raw) {
  return {
    report_version: 3,
    schema_version: raw.schema_version,
    suite_version: raw.suite_version,
    environment: raw.environment,
    platform: raw.platform,
    mode: raw.mode,
    fixture: raw.fixture,
    logical_size: raw.logical_size,
    refresh_rate_hz: raw.refresh_rate_hz,
    samples: raw.samples,
    warmups: raw.warmups,
    diagnostic_tracing: raw.diagnostic_tracing,
  };
}

function stable(value) {
  if (Array.isArray(value)) return value.map(stable);
  if (value && typeof value === 'object') {
    return Object.fromEntries(Object.keys(value).sort().map((key) => [key, stable(value[key])]));
  }
  return value;
}

function worstScenario(scenarios, predicate, metric = 'duration_ms') {
  return scenarios.filter(predicate).reduce((worst, scenario) =>
    !worst || scenario[metric].p95 > worst[metric].p95 ? scenario : worst, null);
}

function performanceHighlights(scenarios, frames, frameBudget, rasterActionable) {
  const pageLoad = worstScenario(scenarios, (s) => ['home_load', 'markets_load', 'details_load'].includes(s.id));
  const interactive = worstScenario(scenarios, (s) => s.id.endsWith('_open_ready'));
  const quote = worstScenario(scenarios, (s) => s.id.endsWith('_quote'));
  const command = worstScenario(scenarios, (s) => /_(preview|submit|cancel)$/.test(s.id));
  const build = worstScenario(scenarios, () => true, 'build_ms');
  const raster = worstScenario(scenarios, () => true, 'raster_ms');
  const frameCount = frames.length;
  const uiSlowFrameCount = frames.filter((frame) => frame.build_ms > frameBudget).length;
  const rasterSlowFrameCount = frames.filter((frame) => frame.raster_ms > frameBudget).length;
  const slowFrameCount = frames.filter((frame) =>
    frame.build_ms > frameBudget || (rasterActionable && frame.raster_ms > frameBudget)).length;
  const result = (scenario) => ({ id: scenario.id, label: scenario.label, p95_ms: scenario.duration_ms.p95 });
  return {
    page_load: result(pageLoad),
    interaction_ready: result(interactive),
    quote: result(quote),
    command: result(command),
    frames: {
      budget_ms: frameBudget,
      count: frameCount,
      slow_count: slowFrameCount,
      slow_percent: slowFrameCount / frameCount * 100,
      slow_basis: rasterActionable ? 'ui_or_raster' : 'ui',
      raster_actionable: rasterActionable,
      ui_slow_count: uiSlowFrameCount,
      raster_slow_count: rasterSlowFrameCount,
      worst_build: { id: build.id, label: build.label, p95_ms: build.build_ms.p95 },
      worst_raster: { id: raster.id, label: raster.label, p95_ms: raster.raster_ms.p95 },
    },
  };
}

export function summarize(raw) {
  if (raw.schema_version !== 1 || raw.suite_version !== 2 || raw.mode !== 'profile' || !['android', 'ios'].includes(raw.platform)) {
    throw new Error('Expected suite version 2 native profile performance data');
  }
  if (!raw.environment?.device_model || !raw.environment?.flutter_version || !raw.environment?.runner ||
      typeof raw.environment.physical_device !== 'boolean' ||
      !raw.commit || !raw.generated_at || !Number.isInteger(raw.samples) || raw.samples < 5 ||
      !Number.isInteger(raw.warmups) || raw.warmups < 1 ||
      !raw.machine?.host?.cpu_model || !Number.isInteger(raw.machine.host.logical_cores) ||
      raw.machine.host.logical_cores < 1 || !Number.isFinite(raw.machine.host.memory_bytes) ||
      !Number.isFinite(raw.refresh_rate_hz) || raw.refresh_rate_hz <= 0 ||
      !Number.isFinite(raw.logical_size?.width) || raw.logical_size.width <= 0 ||
      !Number.isFinite(raw.logical_size?.height) || raw.logical_size.height <= 0) {
    throw new Error('Incomplete measurement environment');
  }
  if (!Array.isArray(raw.scenarios) || raw.scenarios.length !== scenarioIds.length ||
      new Set(raw.scenarios.map((s) => s.id)).size !== scenarioIds.length ||
      scenarioIds.some((id) => !raw.scenarios.some((s) => s.id === id))) {
    throw new Error('Missing or duplicate performance scenarios');
  }
  const budget = 1000 / raw.refresh_rate_hz;
  const rasterActionable = raw.environment.physical_device !== false;
  const uniqueFrames = new Map();
  const scenarios = raw.scenarios.map((s) => {
    const duration = distribution(s.duration_ms, s.id);
    if (duration.count !== raw.samples || !Array.isArray(s.frames) || !s.frames.length) {
      throw new Error(`Incomplete measured actions/frames: ${s.id}`);
    }
    for (const frame of s.frames) {
      if (!Number.isSafeInteger(frame.build_start_us) || frame.build_start_us < 0) {
        throw new Error(`Invalid frame timestamp: ${s.id}`);
      }
      uniqueFrames.set(frame.build_start_us, frame);
    }
    const build = distribution(s.frames.map((f) => f.build_ms), `${s.id} build`);
    const raster = distribution(s.frames.map((f) => f.raster_ms), `${s.id} raster`);
    const total = distribution(s.frames.map((f) => f.total_ms), `${s.id} total`);
    const uiSlow = s.frames.filter((f) => f.build_ms > budget).length;
    const rasterSlow = s.frames.filter((f) => f.raster_ms > budget).length;
    const slow = s.frames.filter((f) =>
      f.build_ms > budget || (rasterActionable && f.raster_ms > budget)).length;
    return { id: s.id, label: s.label, duration_ms: duration, build_ms: build, raster_ms: raster,
      total_ms: total, frame_count: s.frames.length, slow_frame_count: slow,
      ui_slow_frame_count: uiSlow, raster_slow_frame_count: rasterSlow,
      slow_frames_percent: slow / s.frames.length * 100 };
  });
  return { schema_version: 1, commit: raw.commit, generated_at: raw.generated_at,
    compatibility: compatibility(raw), machine: raw.machine, frame_budget_ms: budget,
    highlights: performanceHighlights(scenarios, [...uniqueFrames.values()], budget, rasterActionable), scenarios };
}

export function compare(current, baseline) {
  if (!baseline) return { comparable: false, reason: '首次运行或没有可用的 main 基线', rows: [] };
  if (JSON.stringify(stable(current.compatibility)) !== JSON.stringify(stable(baseline.compatibility))) {
    return { comparable: false, reason: '设备、Flutter、采样配置或场景版本与基线不同', rows: [] };
  }
  const rows = [];
  for (const scenario of current.scenarios) {
    const old = baseline.scenarios.find((s) => s.id === scenario.id);
    if (!old) return { comparable: false, reason: '基线场景不完整', rows: [] };
    const metrics = [['duration_ms', '操作 P95', 20], ['build_ms', 'UI 帧 P95', 3]];
    if (current.highlights.frames.raster_actionable) metrics.push(['raster_ms', '光栅帧 P95', 3]);
    for (const [metric, label, floor] of metrics) {
      const value = scenario[metric].p95;
      const before = old[metric].p95;
      const delta = value - before;
      rows.push({ id: scenario.id, label: scenario.label, metric, metric_label: label, before, value,
        delta, percent: before > 0 ? delta / before * 100 : null,
        regression: delta > Math.max(before * .2, floor) });
    }
    rows.push({ id: scenario.id, label: scenario.label, metric: 'slow_frames_percent', metric_label: '慢帧比例',
      before: old.slow_frames_percent, value: scenario.slow_frames_percent,
      delta: scenario.slow_frames_percent - old.slow_frames_percent,
      regression: scenario.slow_frames_percent - old.slow_frames_percent > 5 });
  }
  return { comparable: true, baseline_commit: baseline.commit, rows };
}

const esc = (value) => String(value).replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
const fmt = (v) => Number(v).toFixed(2);
const gib = (bytes) => `${(Number(bytes) / 1024 ** 3).toFixed(1)} GiB`;
const shortRevision = (value) => String(value).slice(0, 12);
const markdownText = (v) => String(v).replace(/[|\r\n]/g, ' ');

export function markdown(report, comparison) {
  const env = report.compatibility.environment;
  const machine = report.machine;
  const highlights = report.highlights;
  const rasterActionable = highlights.frames.raster_actionable;
  const slowLabel = rasterActionable ? '慢帧' : 'UI 慢帧';
  const warnings = comparison.rows.filter((r) => r.regression);
  const lines = ['## 原生 Flutter 性能报告', '',
    `平台：${markdownText(report.compatibility.platform)} · ${markdownText(env.device_model)} · profile · Flutter ${markdownText(env.flutter_version)}`,
    `每场景 ${report.compatibility.samples} 次采样，排除 ${report.compatibility.warmups} 次预热；刷新率 ${fmt(report.compatibility.refresh_rate_hz)} Hz。`,
    '', `固定仓库数据，不含网络、钱包签名或链上确认；页面加载不代表冷启动。${rasterActionable ? '慢帧指 UI 或光栅耗时超过设备帧预算。' : '模拟器慢帧只按 UI 耗时是否超过设备帧预算计算。'}`, '',
    ...(env.physical_device === false ? ['当前为模拟器数据；软件 GPU 光栅耗时仅保留用于诊断，不参与慢帧、退化提示或门禁。真机性能需在固定真机上复测。', ''] : []),
    ...(report.compatibility.diagnostic_tracing ? ['已启用诊断 tracing，数值包含追踪开销，不用于常规性能基线。', ''] : []),
    comparison.comparable ? `基线：\`${markdownText(comparison.baseline_commit)}\`；${warnings.length} 项退化提示。` : `未比较：${comparison.reason}。`, '',
    '### 总结', '',
    '| 维度 | P95 / 状态 | 场景 |', '|---|---:|---|',
    `| 页面加载 | ${fmt(highlights.page_load.p95_ms)} ms | ${markdownText(highlights.page_load.label)} |`,
    `| 面板可交互 | ${fmt(highlights.interaction_ready.p95_ms)} ms | ${markdownText(highlights.interaction_ready.label)} |`,
    `| 报价更新 | ${fmt(highlights.quote.p95_ms)} ms | ${markdownText(highlights.quote.label)} |`,
    `| 确认 / 提交 / 撤单 | ${fmt(highlights.command.p95_ms)} ms | ${markdownText(highlights.command.label)} |`,
    `| 帧健康 | ${fmt(highlights.frames.slow_percent)}% ${slowLabel} (${highlights.frames.slow_count}/${highlights.frames.count}) | UI ${fmt(highlights.frames.worst_build.p95_ms)} ms / 光栅 ${fmt(highlights.frames.worst_raster.p95_ms)} ms${rasterActionable ? '' : '（诊断）'} |`,
    '', '### 测试机器', '',
    '| 项目 | 参数 |', '|---|---|',
    `| Runner | ${markdownText(env.runner)} |`,
    `| 主机 | ${markdownText(machine.host.os)} · ${markdownText(machine.host.arch)} |`,
    `| 主机 CPU | ${markdownText(machine.host.cpu_model)} · ${machine.host.logical_cores} 逻辑核 |`,
    `| 主机内存 | ${gib(machine.host.memory_bytes)} |`,
    `| 移动设备 | ${markdownText(machine.device.manufacturer)} ${markdownText(machine.device.model)} · ${markdownText(env.os_version)} |`,
    `| 设备 CPU / 内存 | ${markdownText(machine.device.cpu_abi ?? '未知')} · ${machine.device.cpu_cores ?? '未知'} 核 · ${machine.device.memory_bytes ? gib(machine.device.memory_bytes) : '未知'} |`,
    `| 屏幕 | ${machine.device.display_width_px && machine.device.display_height_px ? `${machine.device.display_width_px}×${machine.device.display_height_px}px` : '未知'} · ${fmt(report.compatibility.logical_size.width)}×${fmt(report.compatibility.logical_size.height)}dp · ${machine.device.density_dpi ?? '未知'} dpi · ${fmt(report.compatibility.refresh_rate_hz)} Hz |`,
    `| Flutter | ${markdownText(env.flutter_version)} · ${markdownText(shortRevision(env.flutter_revision))} |`, '',
    '### 全部操作', '',
    `| 场景 | 操作 P50 / P95 (ms) | UI P95 (ms) | 光栅 P95 (ms) | ${slowLabel} | 操作 P95 对比 |`,
    '|---|---:|---:|---:|---:|---:|'];
  for (const s of report.scenarios) {
    const delta = comparison.rows.find((r) => r.id === s.id && r.metric === 'duration_ms');
    const change = delta ? `${delta.regression ? '🔴' : '🟢'} ${delta.percent === null ? '—' : `${delta.percent >= 0 ? '+' : ''}${fmt(delta.percent)}%`}` : '—';
    lines.push(`| ${markdownText(s.label)} | ${fmt(s.duration_ms.p50)} / ${fmt(s.duration_ms.p95)} | ${fmt(s.build_ms.p95)} | ${fmt(s.raster_ms.p95)} | ${fmt(s.slow_frames_percent)}% (${s.slow_frame_count}/${s.frame_count}) | ${change} |`);
  }
  if (warnings.length) {
    lines.push('', '### 退化提示', '', ...warnings.map((r) => `- ${markdownText(r.label)} / ${r.metric_label}：${fmt(r.before)} → ${fmt(r.value)} ${r.metric === 'slow_frames_percent' ? '%' : 'ms'}`));
  }
  lines.push('', '下载 `native-performance` 附件，打开 `report.html` 查看交互对比、分布及趋势；`raw.json` 保留逐次耗时和逐帧数据。',
    '', `提示阈值：耗时增加超过 max(20%, 20ms)，UI${rasterActionable ? '/光栅' : ''} P95 增加超过 max(20%, 3ms)，${slowLabel}比例增加超过 5 个百分点。默认仅提示，固定设备可启用严格门禁。`);
  return `${lines.join('\n')}\n`;
}

export function html(report, comparison, raw, history) {
  // Embedded data is inert JSON, with HTML-significant characters escaped.
  const data = JSON.stringify({ report, comparison, raw, history }).replace(/</g, '\\u003c').replace(/>/g, '\\u003e').replace(/&/g, '\\u0026');
  const env = report.compatibility.environment;
  const machine = report.machine;
  const highlights = report.highlights;
  const rasterActionable = highlights.frames.raster_actionable;
  const slowLabel = rasterActionable ? '慢帧' : 'UI 慢帧';
  const comparisonText = comparison.comparable
    ? `与 main ${comparison.baseline_commit.slice(0, 12)} 比较；${comparison.rows.filter((r) => r.regression).length} 项退化提示。`
    : `未比较：${comparison.reason}。`;
  const overview = [
    ['页面加载 P95', highlights.page_load.p95_ms, highlights.page_load.label],
    ['面板可交互 P95', highlights.interaction_ready.p95_ms, highlights.interaction_ready.label],
    ['报价更新 P95', highlights.quote.p95_ms, highlights.quote.label],
    ['命令操作 P95', highlights.command.p95_ms, highlights.command.label],
  ].map(([label, value, detail]) => `<div class="metric"><span>${esc(label)}</span><strong>${fmt(value)} ms</strong><small>${esc(detail)}</small></div>`).join('');
  const display = machine.device.display_width_px && machine.device.display_height_px
    ? `${machine.device.display_width_px}×${machine.device.display_height_px}px`
    : '未知';
  const machineRows = [
    ['Runner', env.runner],
    ['主机', `${machine.host.os} · ${machine.host.arch}`],
    ['主机 CPU', `${machine.host.cpu_model} · ${machine.host.logical_cores} 逻辑核`],
    ['主机内存', gib(machine.host.memory_bytes)],
    ['移动设备', `${machine.device.manufacturer} ${machine.device.model} · ${env.os_version}`],
    ['设备 CPU / 内存', `${machine.device.cpu_abi ?? '未知'} · ${machine.device.cpu_cores ?? '未知'} 核 · ${machine.device.memory_bytes ? gib(machine.device.memory_bytes) : '未知'}`],
    ['屏幕', `${display} · ${fmt(report.compatibility.logical_size.width)}×${fmt(report.compatibility.logical_size.height)}dp · ${machine.device.density_dpi ?? '未知'} dpi · ${fmt(report.compatibility.refresh_rate_hz)} Hz`],
    ['Flutter', `${env.flutter_version} · ${shortRevision(env.flutter_revision)}`],
  ].map(([label, value]) => `<div><dt>${esc(label)}</dt><dd>${esc(value)}</dd></div>`).join('');
  return `<!doctype html>
<html lang="zh-CN"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Nobell 原生性能报告</title>
<style>
body{font:15px system-ui;margin:0;background:#f3f5f8;color:#182538}main{max-width:1180px;margin:auto;padding:28px}h1{font-size:26px}h2{font-size:18px}section{background:white;padding:22px;border-radius:8px;margin:18px 0}select{padding:8px;max-width:100%;margin:4px 12px 4px 0}table{border-collapse:collapse;width:100%;font-size:13px}th,td{text-align:left;padding:10px;border-bottom:1px solid #e7ebf0}tr.warn{background:#fff0ee}.scroll{overflow:auto}svg{width:100%;height:auto}p{line-height:1.65;color:#536176}.legend{color:#2563eb}.baseline{color:#8895a7}#tip{min-height:24px}svg circle:hover{r:6;cursor:pointer}.overview{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));border:1px solid #e7ebf0;border-radius:6px}.metric{display:grid;gap:5px;padding:16px;border-right:1px solid #e7ebf0}.metric:last-child{border:0}.metric span,.metric small,dt{color:#69778a}.metric strong{font-size:20px}.metric small{font-size:12px}.frame-health{margin:16px 0 0}.specs{display:grid;grid-template-columns:1fr 1fr;margin:0}.specs div{display:grid;grid-template-columns:120px 1fr;padding:9px 0;border-bottom:1px solid #e7ebf0}.specs div:nth-child(odd){margin-right:24px}.specs dt,.specs dd{margin:0}.specs dd{overflow-wrap:anywhere}@media(max-width:760px){main{padding:16px}.overview,.specs{grid-template-columns:1fr}.metric{border-right:0;border-bottom:1px solid #e7ebf0}.specs div:nth-child(odd){margin-right:0}}
</style>
<main><h1>Nobell · 原生 Flutter 性能报告</h1><p id="meta"></p><p>固定仓库数据；不含真实网络、钱包签名或链上确认。页面加载为进入页面到数据就绪，不代表 App 冷启动。${rasterActionable ? '慢帧表示 UI 或光栅耗时超过设备刷新率预算。' : '模拟器慢帧只按 UI 耗时是否超过设备刷新率预算计算。'}</p>${report.compatibility.environment.physical_device === false ? '<p>当前为模拟器数据；软件 GPU 光栅耗时仅保留用于诊断，不参与慢帧、退化提示或门禁。真机性能需在固定真机上复测。</p>' : ''}
${report.compatibility.diagnostic_tracing ? '<p><strong>诊断 tracing 已启用：</strong>本报告包含追踪开销，不用于常规性能基线。</p>' : ''}
<section><h2>总结</h2><p>${esc(comparisonText)}</p><div class="overview">${overview}</div><p class="frame-health">帧健康：${fmt(highlights.frames.slow_percent)}% ${slowLabel}（${highlights.frames.slow_count}/${highlights.frames.count}）；最差 UI P95 ${fmt(highlights.frames.worst_build.p95_ms)} ms，最差光栅 P95 ${fmt(highlights.frames.worst_raster.p95_ms)} ms${rasterActionable ? '' : '（诊断）'}，帧预算 ${fmt(highlights.frames.budget_ms)} ms。</p></section>
<section><h2>测试机器</h2><dl class="specs">${machineRows}</dl></section>
<section><h2>全部关键操作</h2><p id="comparison"></p><div class="scroll"><table id="summary"></table></div></section>
<section><h2>场景分析</h2><label>场景 <select id="scenario"></select></label><label>指标 <select id="metric"><option value="duration_ms">操作耗时</option><option value="build_ms">UI 帧耗时</option><option value="raster_ms">光栅帧耗时</option></select></label>
<p class="legend">蓝色：本次 <span class="baseline">灰色：main 基线</span></p><h2>P95 对比（ms）</h2><div id="bars"></div><h2>本次样本分布</h2><div id="distribution"></div><h2>历史趋势（P95，ms）</h2><p>相同设备和测试配置的最近 30 次 main 报告，加上本次运行。指向数据点查看 commit 和数值。</p><div id="trend"></div><p id="tip" aria-live="polite"></p></section>
<p>Commit: ${esc(report.commit)} · ${esc(report.generated_at)}。原始数据：<a href="raw.json">raw.json</a>；汇总：<a href="report.json">report.json</a>；历史：<a href="history.json">history.json</a>。</p></main>
<script id="data" type="application/json">${data}</script>
<script>
const {report,comparison,raw,history}=JSON.parse(document.getElementById('data').textContent);
const $=id=>document.getElementById(id);const fmt=v=>Number(v).toFixed(2);const escape=v=>String(v).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
$('meta').textContent=report.compatibility.platform+' · '+report.compatibility.environment.device_model+' · '+report.compatibility.environment.os_version+' · profile · Flutter '+report.compatibility.environment.flutter_version+' · '+report.compatibility.samples+' 次采样 / '+report.compatibility.warmups+' 次预热 · '+fmt(report.compatibility.refresh_rate_hz)+' Hz';
$('comparison').textContent=comparison.comparable?'与 main '+comparison.baseline_commit.slice(0,12)+' 比较；'+comparison.rows.filter(r=>r.regression).length+' 项退化提示。':'未比较：'+comparison.reason;
$('summary').innerHTML='<tr><th>场景</th><th>操作 P50 / P95 ms</th><th>UI P95 ms</th><th>光栅 P95 ms</th><th>${slowLabel}比例</th><th>帧数</th></tr>'+report.scenarios.map(s=>'<tr class="'+(comparison.rows.some(r=>r.id===s.id&&r.regression)?'warn':'')+'"><td>'+escape(s.label)+'</td><td>'+fmt(s.duration_ms.p50)+' / '+fmt(s.duration_ms.p95)+'</td><td>'+fmt(s.build_ms.p95)+'</td><td>'+fmt(s.raster_ms.p95)+'</td><td>'+fmt(s.slow_frames_percent)+'%</td><td>'+s.frame_count+'</td></tr>').join('');
report.scenarios.forEach(s=>{const o=document.createElement('option');o.value=s.id;o.textContent=s.label;$('scenario').append(o)});
function svg(body,h=200){return '<svg viewBox="0 0 1000 '+h+'" role="img">'+body+'</svg>'}
function update(){const id=$('scenario').value,metric=$('metric').value,s=report.scenarios.find(s=>s.id===id),r=raw.scenarios.find(s=>s.id===id);const base=comparison.rows.find(r=>r.id===id&&r.metric===metric);const max=Math.max(s[metric].p95,base?.before??0,1);$('bars').innerHTML=svg([[s[metric].p95,'本次','#2563eb'],...(base?[[base.before,'main','#8895a7']]:[])].map(([v,l,c],i)=>'<text x="0" y="'+(32+i*62)+'">'+l+'</text><rect x="80" y="'+(12+i*62)+'" width="'+(v/max*800)+'" height="30" fill="'+c+'"/><text x="'+(90+v/max*800)+'" y="'+(32+i*62)+'">'+fmt(v)+'</text>').join(''),145);
const values=metric==='duration_ms'?r.duration_ms:r.frames.map(f=>f[metric]);const upper=Math.max(...values,metric==='duration_ms'?0:report.frame_budget_ms,1);const bins=Array(20).fill(0);values.forEach(v=>bins[Math.min(19,Math.floor(v/upper*20))]++);const high=Math.max(...bins,1);let drawing=bins.map((n,i)=>'<rect x="'+(50+i*46)+'" y="'+(170-n/high*140)+'" width="40" height="'+(n/high*140)+'" fill="#2563eb"><title>'+fmt(i/20*upper)+'–'+fmt((i+1)/20*upper)+' ms: '+n+' 个样本</title></rect>').join('');drawing+='<text x="50" y="195">0 ms</text><text x="870" y="195">'+fmt(upper)+' ms</text><text x="50" y="20">样本数 '+values.length+'；最高柱 '+high+'</text>';if(metric!=='duration_ms'){const x=50+report.frame_budget_ms/upper*920;drawing+='<line x1="'+x+'" x2="'+x+'" y1="25" y2="175" stroke="#dc2626" stroke-dasharray="4"/><text x="'+Math.min(x,760)+'" y="20">帧预算 '+fmt(report.frame_budget_ms)+' ms</text>'}$('distribution').innerHTML=svg(drawing,210);
const points=history.map(h=>({commit:h.commit,date:h.generated_at,value:h.scenarios.find(s=>s.id===id)?.[metric]?.p95})).filter(p=>Number.isFinite(p.value));const top=Math.max(...points.map(p=>p.value),1);const coords=points.map((p,i)=>({x:60+i/Math.max(points.length-1,1)*880,y:170-p.value/top*140,...p}));$('trend').innerHTML=svg('<text x="0" y="25">'+fmt(top)+'</text><text x="0" y="175">0</text><path d="'+coords.map((p,i)=>(i?'L':'M')+p.x+','+p.y).join(' ')+'" fill="none" stroke="#2563eb" stroke-width="2"/>'+coords.map(p=>'<circle cx="'+p.x+'" cy="'+p.y+'" r="4" fill="#2563eb"><title>'+escape(p.commit.slice(0,12)+' · '+p.date+' · '+fmt(p.value)+' ms')+'</title></circle>').join('')+'<text x="60" y="200">'+(points[0]?.commit.slice(0,8)??'')+'</text><text x="860" y="200">'+(points.at(-1)?.commit.slice(0,8)??'')+'</text>',215);$('tip').textContent=points.length<2?'积累至少两次兼容报告后可查看趋势。':'';}
$('scenario').onchange=update;$('metric').onchange=update;update();
</script></html>`;
}

async function optionalJson(path) {
  try { return JSON.parse(await readFile(path, 'utf8')); }
  catch (error) { if (error.code === 'ENOENT') return null; throw error; }
}

export async function generate({ input = 'build/performance/raw.json', output = 'build/performance', baselineDir = 'build/performance-baseline', gate = false } = {}) {
  const raw = JSON.parse(await readFile(input, 'utf8'));
  const report = summarize(raw);
  const baseline = await optionalJson(`${baselineDir}/report.json`);
  const comparison = compare(report, baseline);
  const previous = await optionalJson(`${baselineDir}/history.json`) ?? [];
  const signature = JSON.stringify(stable(report.compatibility));
  const history = previous.filter((h) => h.commit !== report.commit && JSON.stringify(stable(h.compatibility)) === signature).slice(-29);
  history.push(report);
  const summary = markdown(report, comparison);
  await mkdir(output, { recursive: true });
  await Promise.all([
    writeFile(`${output}/report.json`, `${JSON.stringify({ ...report, comparison }, null, 2)}\n`),
    writeFile(`${output}/history.json`, `${JSON.stringify(history, null, 2)}\n`),
    writeFile(`${output}/summary.md`, summary),
    writeFile(`${output}/report.html`, html(report, comparison, raw, history)),
    ...(resolve(input) !== resolve(`${output}/raw.json`) ? [writeFile(`${output}/raw.json`, `${JSON.stringify(raw, null, 2)}\n`)] : []),
  ]);
  const regressions = comparison.rows.filter((r) => r.regression);
  console.log(`Performance report: ${output}/report.html (${regressions.length} regression warnings)`);
  if (gate && regressions.length) process.exitCode = 1;
  return { report, comparison, history, summary };
}

if (process.argv[1] && import.meta.url === pathToFileURL(resolve(process.argv[1])).href) {
  const args = process.argv.slice(2);
  const options = {};
  while (args.length) {
    const arg = args.shift();
    if (arg === '--fail-on-regression') options.gate = true;
    else if (['--input', '--output', '--baseline-dir'].includes(arg) && args.length) {
      options[{ '--input': 'input', '--output': 'output', '--baseline-dir': 'baselineDir' }[arg]] = args.shift();
    } else throw new Error(`Unknown or missing argument: ${arg}`);
  }
  const result = await generate(options);
  if (process.env.GITHUB_STEP_SUMMARY) {
    await appendFile(process.env.GITHUB_STEP_SUMMARY, result.summary);
  }
}
