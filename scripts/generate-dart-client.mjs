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
  "-g", "dart-dio",
  "-i", "/local/openapi/main.yaml",
  "-o", `/local/${relativeOutput}`,
  "--additional-properties=pubName=rwa_api_client,pubDescription=Generated_RWA_Trading_Platform_API_client,pubVersion=1.0.0,enumUnknownDefaultCase=true,legacyDiscriminatorBehavior=false",
], {
  cwd: rootDir,
  stdio: "inherit",
});
