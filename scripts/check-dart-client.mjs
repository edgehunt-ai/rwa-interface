import { rmSync } from "node:fs";
import { resolve } from "node:path";
import { execFileSync } from "node:child_process";

const rootDir = resolve(new URL("..", import.meta.url).pathname);
const tmpClient = ".contract-cache/rwa_api_client_check";
try {
  execFileSync("node", ["scripts/generate-dart-client.mjs", tmpClient], { cwd: rootDir, stdio: "inherit" });
  execFileSync("diff", ["-qr", "packages/rwa_api_client", tmpClient], { cwd: rootDir, stdio: "inherit" });
  console.log("Dart API client is current.");
} finally {
  rmSync(resolve(rootDir, tmpClient), { recursive: true, force: true });
}
