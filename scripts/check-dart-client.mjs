import { rmSync } from "node:fs";
import { resolve } from "node:path";
import { execFileSync } from "node:child_process";

const rootDir = resolve(new URL("..", import.meta.url).pathname);
const tmpClient = ".contract-cache/rwa_api_client_check";
try {
  execFileSync("node", ["scripts/generate-dart-client.mjs", tmpClient], { cwd: rootDir, stdio: "inherit" });
  // .dart_tool and pubspec.lock are machine-local build/dependency artifacts
  // and are not part of the tracked generated package. Remove them from both
  // sides before the required host diff so local preparation cannot create a
  // false drift.
  rmSync(resolve(rootDir, "packages/rwa_api_client/.dart_tool"), { recursive: true, force: true });
  rmSync(resolve(rootDir, "packages/rwa_api_client/pubspec.lock"), { force: true });
  rmSync(resolve(rootDir, tmpClient, "pubspec.lock"), { force: true });
  execFileSync("diff", ["-qr", "packages/rwa_api_client", tmpClient], { cwd: rootDir, stdio: "inherit" });
  console.log("Dart API client is current.");
} finally {
  rmSync(resolve(rootDir, tmpClient), { recursive: true, force: true });
}
