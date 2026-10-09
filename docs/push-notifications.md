# Push Notifications

The app registers an FCM token with `POST /v1/me/devices` after an authenticated
Android or iOS launch. It repeats the request whenever Firebase rotates the
token, and removes the registered device before logout.

Before testing a physical device, configure the Firebase project for the app:

1. Run `dart pub global activate flutterfire_cli` once, then run
   `flutterfire configure --project=rwa-trade-f6f60 --platforms=android,ios --android-package-name=global.nobell.app --ios-bundle-id=global.nobell.app`
   from this repository. Commit the generated `lib/firebase_options.dart`,
   `android/app/google-services.json`, and `firebase.json`.
   Both platforms use `global.nobell.app`; their Firebase app registrations
   are in the existing `rwa-trade-f6f60` project.
2. In Apple Developer, enable Push Notifications for the `global.nobell.app`
   app identifier and upload the APNs authentication key to the new Nobell iOS
   app in Firebase. Regenerate provisioning profiles for this bundle ID.
3. Configure the API service with FCM HTTP v1 credentials. Do not commit a
   service-account JSON file; it is a server-side secret. Send a `data.route`
   value using one of the supported in-app paths: `/activity`, `/assets`,
   `/funding/deposit`, or `/trade`.

The backend remains authoritative for event eligibility and user preferences.
The client only registers the device and handles a notification tap.
