import { existsSync, lstatSync, readFileSync, realpathSync, rmSync, writeFileSync } from "node:fs";
import { relative, resolve } from "node:path";
import { execFileSync } from "node:child_process";
import { pathToFileURL } from "node:url";

export function resolveSafeOutput(rootDir, requestedOutput) {
  const outputDir = resolve(rootDir, requestedOutput ?? "packages/rwa_api_client");
  const relativeOutput = relative(rootDir, outputDir);
  const allowed = relativeOutput === "packages/rwa_api_client" ||
    (relativeOutput.startsWith(".contract-cache/") && relativeOutput !== ".contract-cache/");
  if (!allowed) {
    throw new Error("Dart client output must be the generated package or a contract-cache child");
  }
  try {
    const rootRealPath = realpathSync(rootDir);
    if (lstatSync(outputDir).isSymbolicLink() ||
        !realpathSync(outputDir).startsWith(`${rootRealPath}/`)) {
      throw new Error("Dart client output must not escape through a symbolic link");
    }
  } catch (error) {
    if (error?.code !== "ENOENT") throw error;
  }
  return { outputDir, relativeOutput };
}

export function generateClient(requestedOutput) {
  const rootDir = resolve(new URL("..", import.meta.url).pathname);
  const contractSpec = resolve(rootDir, "contracts/rwa-api-contract/openapi/main.yaml");
  if (!existsSync(contractSpec)) {
    throw new Error(
      "Missing contract submodule. Run: git submodule update --init --recursive",
    );
  }
  const { outputDir, relativeOutput } = resolveSafeOutput(rootDir, requestedOutput);
  rmSync(outputDir, { recursive: true, force: true });
  execFileSync("npx", ["openapi-generator-cli", "generate", "--generator-key", "rwa-api-client"], {
    cwd: rootDir,
    stdio: "inherit",
    env: { ...process.env, RWA_DART_CLIENT_OUTPUT: relativeOutput },
  });
  const generatorConfig = JSON.parse(readFileSync(resolve(rootDir, "openapitools.json"), "utf8"));
  const buildRunnerVersion = generatorConfig["generator-cli"].generators["rwa-api-client"]
    .additionalProperties.buildRunnerVersion;
  const pubspecPath = resolve(outputDir, "pubspec.yaml");
  const pubspec = readFileSync(pubspecPath, "utf8").replace(
    "  build_runner: any",
    `  build_runner: '${buildRunnerVersion}'`,
  );
  writeFileSync(pubspecPath, pubspec);
  execFileSync("dart", ["pub", "get"], { cwd: outputDir, stdio: "inherit" });
  execFileSync("dart", ["run", "build_runner", "build"], { cwd: outputDir, stdio: "inherit" });
  // 二次源码已提交；本机绝对路径相关的 build cache 和 pub resolution lock
  // 不属于可复现 artifact（package lock 由应用根目录统一管理）。
  rmSync(resolve(outputDir, ".dart_tool"), { recursive: true, force: true });
  rmSync(resolve(outputDir, "pubspec.lock"), { force: true });
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  generateClient(process.argv[2]);
}
