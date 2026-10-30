# iOS releases in GitHub Actions

`Release Mobile` builds and signs an App Store Connect IPA on the hosted macOS
runner. The GitHub artifact and release asset are named `nobell-ios.ipa`.
This is an App Store distribution package; install test builds through
TestFlight after uploading them to App Store Connect.

The existing release rules still apply: formal versions publish only from
`main`, after CI succeeds. Manual builds from other branches require a
prerelease version in `pubspec.yaml`. An already published version is skipped;
a workflow-only rebuild does not upload the same build to TestFlight again.

## Required signing configuration

In Apple Developer, register the explicit App ID `global.nobell.app` and enable:

- Associated Domains
- Sign in with Apple
- Push Notifications

Create an **App Store Connect distribution provisioning profile** for that
App ID and an **Apple Distribution** certificate. Export the certificate and
its private key together as a password-protected `.p12` from Keychain Access.
Regenerate the profile after adding capabilities or changing the certificate.
Development, Ad Hoc, and enterprise profiles cannot be used by this workflow.

Configure these repository settings under **Settings → Secrets and variables →
Actions**:

| Type | Name | Value |
| --- | --- | --- |
| Variable | `APPLE_TEAM_ID` | The publishing team's 10-character ID; also used by the Passkey site deployment |
| Secret | `IOS_DISTRIBUTION_CERTIFICATE_BASE64` | Base64-encoded `.p12`, including its private key |
| Secret | `IOS_DISTRIBUTION_CERTIFICATE_PASSWORD` | The `.p12` export password |
| Secret | `IOS_PROVISIONING_PROFILE_BASE64` | Base64-encoded App Store Connect `.mobileprovision` |

On macOS, copy a file's base64 representation directly into a GitHub Secret:

```sh
base64 -i AppleDistribution.p12 | pbcopy
base64 -i Nobell_AppStore.mobileprovision | pbcopy
```

Run the commands separately and save each copied value to its corresponding
Secret. Do not commit the files or paste private keys into issues or logs.

The existing Flutter build variables remain required: `API_BASE_URL`,
`PRIVY_APP_ID`, `PRIVY_CLIENT_ID`, `PRIVY_EXPORT_URL`, `PRIVY_APP_URL_SCHEME`, and
`REOWN_PROJECT_ID`. Enable Apple login in Privy and configure the mobile client
and callback scheme. Passkey domain association and Firebase's APNs key remain
separate setup steps; see [Passkeys](passkeys.md) and
[push notifications](push-notifications.md).

## Optional TestFlight upload

First create the app in App Store Connect with Bundle ID `global.nobell.app`.
Create a **team API Key** under **Users and Access → Integrations → App Store
Connect API**, with permission to upload builds (for example, App Manager).
Download its `.p8` key and configure all three repository Secrets:

| Secret | Value |
| --- | --- |
| `APP_STORE_CONNECT_KEY_ID` | The API Key's 10-character Key ID |
| `APP_STORE_CONNECT_ISSUER_ID` | The team API Key's Issuer ID |
| `APP_STORE_CONNECT_PRIVATE_KEY_BASE64` | Base64-encoded contents of the downloaded `AuthKey_….p8` |

```sh
base64 -i AuthKey_YOURKEYID.p8 | pbcopy
```

If all three Secrets are absent, the signed IPA is still built and published;
TestFlight upload is skipped and recorded in the Actions summary. A partially
configured API Key fails with the names of the missing settings. Invalid
credentials or an upload error also fail the job; the IPA artifact is uploaded
before TestFlight, so it remains downloadable if the upload fails.

Upload runs only for a new release. The existing `pubspec.yaml` build number
must be unused in App Store Connect; export does not increment it automatically.
For a prerelease such as `0.8.1-rc.1+29`, the IPA version is `0.8.1` and its build
number is `29`; the GitHub release retains the prerelease label. Apple's
processing, export compliance, and any external beta review still happen after
upload. This workflow does not submit the app for App Store release or assign
TestFlight tester groups.

## Signing checks and credential cleanup

The workflow imports the certificate into a temporary keychain, installs the
profile, and generates a manual-signing configuration used only by the Runner
target. The profile is checked for expiration, team, explicit Bundle ID,
matching certificate/private key, and all three capabilities before building.
The exported IPA is checked again for a valid signature, matching embedded
profile, Apple login, the configured Passkey domain, and production APNs.

Temporary signing configuration, certificate files, API private keys, the
installed profile, and the temporary keychain are removed even when a build or
upload step fails. The runner's original keychain search list is restored.

Local regression checks do not require macOS or real signing material:

```sh
python3 -m unittest discover -s scripts -p 'ios_release_test.py'
```

Actual signed builds and TestFlight uploads require the configured credentials
and the macOS Actions runner. Validate Apple login, Passkey login, and push
delivery on a physical device before publishing to users.
