ENV_FILE ?= .env
FLUTTER_ARGS ?=

REQUIRED_ENV_KEYS := API_BASE_URL PRIVY_APP_ID PRIVY_CLIENT_ID

.PHONY: env-check run

env-check:
	@test -f "$(ENV_FILE)" || { echo "Missing environment file: $(ENV_FILE)" >&2; exit 1; }
	@for key in $(REQUIRED_ENV_KEYS); do \
		grep -Eq "^$${key}=.+$$" "$(ENV_FILE)" || { \
			echo "Missing or empty $${key} in $(ENV_FILE)" >&2; \
			exit 1; \
		}; \
	done

run: env-check
	flutter run --dart-define-from-file="$(ENV_FILE)" $(FLUTTER_ARGS)
