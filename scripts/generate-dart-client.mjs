import { rmSync } from "node:fs";
import { relative, resolve } from "node:path";
import { execFileSync } from "node:child_process";

const rootDir = resolve(new URL("..", import.meta.url).pathname);
const outputDir = process.argv[2] ? resolve(rootDir, process.argv[2]) : resolve(rootDir, "packages/rwa_api_client");
const relativeOutput = relative(rootDir, outputDir);
if (relativeOutput.startsWith("..") || relativeOutput === "") {
  throw new Error("Dart client output must be inside the repository checkout");
}

rmSync(outputDir, { recursive: true, force: true });
execFileSync("npx", [
  "openapi-generator-cli",
  "generate",
  "--generator-key", "rwa-api-client",
], {
  cwd: rootDir,
  stdio: "inherit",
  env: { ...process.env, RWA_DART_CLIENT_OUTPUT: relativeOutput },
});
