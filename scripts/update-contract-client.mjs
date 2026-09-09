import { execFileSync } from 'node:child_process';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';

const rootDir = resolve(new URL('..', import.meta.url).pathname);
const submodulePath = 'contracts/rwa-api-contract';
const npmCommand = process.platform === 'win32' ? 'npm.cmd' : 'npm';

function run(command, args) {
  execFileSync(command, args, { cwd: rootDir, stdio: 'inherit' });
}

function parseCommand(args) {
  if (args.length === 0) return { type: 'update' };
  if (args.length === 1 && args[0] === '--init') return { type: 'init' };
  if (
    (args.length === 1 && ['--help', '-h'].includes(args[0])) ||
    (args.length === 2 && args[0] === '--branch' && ['--help', '-h'].includes(args[1]))
  ) {
    return { type: 'help' };
  }
  if (args.length === 2 && args[0] === '--branch' && args[1]) {
    return { type: 'update', branch: args[1] };
  }
  throw new Error(
    'Usage: npm run api:init, npm run api:update, or npm run api:update:branch -- <branch>',
  );
}

export function updateContractClient(args = process.argv.slice(2)) {
  const command = parseCommand(args);

  if (command.type === 'help') {
    console.log('Usage: npm run api:init');
    console.log('       npm run api:update');
    console.log('       npm run api:update:branch -- <branch>');
    return;
  }

  run('git', ['submodule', 'update', '--init', '--recursive', submodulePath]);
  if (command.type === 'init') return;

  if (command.branch) {
    run('git', ['check-ref-format', '--branch', command.branch]);
    run('git', ['submodule', 'set-branch', '-b', command.branch, submodulePath]);
  }

  run('git', ['submodule', 'update', '--remote', '--checkout', '--recursive', submodulePath]);
  run(npmCommand, ['run', 'client:generate']);
  run(npmCommand, ['run', 'quality:check']);
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  updateContractClient();
}
