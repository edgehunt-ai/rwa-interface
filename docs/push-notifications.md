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
   `/funding/deposit`, `/trade`, or `/activity/<encoded-record-id>`.

The backend remains authoritative for event eligibility and user preferences.
While the app is in the foreground, Firebase messages are displayed as system
notifications using `flutter_local_notifications`, without an in-app snackbar.
Android uses the high-importance `account_updates` channel; iOS presents a local
notification banner and sound. Firebase's automatic iOS foreground presentation
is disabled to avoid duplicate notifications. Background remote notifications
continue to be displayed by the OS.

Tapping a notification opens only one of the supported paths above, including
when a foreground notification is tapped after the app has been terminated.
Receiving a message does not navigate automatically. Foreground listening stops
on logout. Display and sound remain subject to OS notification permissions,
channel settings and Do Not Disturb. No notification settings UI is required.

### Activity detail links

Open a specific record with `/activity/<encoded-activity-record-id>`. Build the route with
`AppRoutes.activityDetailLocation(record.id)` so IDs containing slashes or reserved
characters are encoded correctly. Use the activity record's ID, rather than its
related order ID or transaction hash. The same location works in notification
payloads as either `route` or `deep_link`; for example:

    {"deep_link": "/activity/order%2F123"}

On the web, append the route to the application's existing hash URL, for example
`https://<app-host>/#/activity/order%2F123`. The detail page loads independently
of the activity list's current filters, searches subsequent pages when needed,
and displays the existing activity detail fields. Signed-out users log in from
the detail page and return to that record. Missing records and failed requests
show the corresponding empty or retry state.

External custom scheme URLs are described in [external links](deep-links.md).
Notification payloads continue to use the relative application routes above.
