ENV_FILE ?= .env
FLUTTER_ARGS ?=

REQUIRED_ENV_KEYS := API_BASE_URL PRIVY_APP_ID PRIVY_CLIENT_ID PRIVY_APP_URL_SCHEME REOWN_PROJECT_ID

.PHONY: env-check sync-privy-config run privy-export-dev privy-export-build

env-check:
	@test -f "$(ENV_FILE)" || { echo "Missing environment file: $(ENV_FILE)" >&2; exit 1; }
	@for key in $(REQUIRED_ENV_KEYS); do \
		grep -Eq "^$${key}=.+$$" "$(ENV_FILE)" || { \
			echo "Missing or empty $${key} in $(ENV_FILE)" >&2; \
			exit 1; \
		}; \
	done

sync-privy-config: env-check
	node scripts/sync-privy-url-scheme.mjs "$(ENV_FILE)"

run: sync-privy-config
	flutter run --dart-define-from-file="$(ENV_FILE)" $(FLUTTER_ARGS)

privy-export-dev: env-check
	npm run privy:export:dev

privy-export-build: env-check
	npm run privy:export:build
