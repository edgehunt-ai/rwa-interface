import { resolve } from "node:path";
import { pathToFileURL } from "node:url";

import { generateDartClient } from "../contracts/rwa-api-contract/scripts/generate-dart-client.mjs";

export function generateClient() {
  const rootDir = resolve(new URL("..", import.meta.url).pathname);
  return generateDartClient({
    consumerRootDir: rootDir,
    externalOutputDir: "packages/rwa_api_client",
    metadata: {
      pubName: "rwa_api_client",
      pubDescription:
        "Generated transport client for the RWA Trading Platform API.",
      pubVersion: "1.0.0",
      pubHomepage: "https://github.com/edgehunt-ai/rwa-interface",
      pubRepository: "https://github.com/edgehunt-ai/rwa-interface",
    },
    validateGeneratedClient: false,
    cleanTransient: true,
  });
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  generateClient();
}
