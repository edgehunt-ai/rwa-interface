plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("io.sentry.android.gradle")
}

// sentry_flutter 9.28.0 embeds Sentry Android 8.53.0. One transitive native
// dependency requests 8.22.0's fragment integration; mixed SDK modules make
// the Sentry Android SDK skip initialization entirely at runtime.
configurations.configureEach {
    resolutionStrategy.eachDependency {
        if (requested.group == "io.sentry" && requested.name != "sentry-native-ndk") {
            useVersion("8.53.0")
            because("all Sentry Android SDK integrations must match the core SDK version")
        }
    }
}

android {
    namespace = "global.nobell.app"
    // Current native plugins require API 36 compile metadata. This does not
    // change targetSdk or the minimum install version.
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "global.nobell.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 28
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        val keystorePath = System.getenv("ANDROID_KEYSTORE_PATH")
        val storePassword = System.getenv("ANDROID_KEYSTORE_PASSWORD")
        val keyAlias = System.getenv("ANDROID_KEY_ALIAS")
        val keyPassword = System.getenv("ANDROID_KEY_PASSWORD")
        if (!keystorePath.isNullOrBlank() &&
            !storePassword.isNullOrBlank() &&
            !keyAlias.isNullOrBlank() &&
            !keyPassword.isNullOrBlank()
        ) {
            create("release") {
                storeFile = file(keystorePath)
                this.storePassword = storePassword
                this.keyAlias = keyAlias
                this.keyPassword = keyPassword
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
            signingConfig = if (
                !System.getenv("ANDROID_KEYSTORE_PATH").isNullOrBlank()
            ) {
                signingConfigs.getByName("release")
            } else {
                // Keep local `flutter run --release` usable without credentials.
                signingConfigs.getByName("debug")
            }
        }
    }

    testOptions {
        unitTests.isIncludeAndroidResources = true
    }
}

sentry {
    org.set(System.getenv("SENTRY_ORG") ?: "dodo-k4")
    projectName.set(System.getenv("SENTRY_PROJECT") ?: "rwa")
    authToken.set(System.getenv("SENTRY_AUTH_TOKEN"))
    autoUploadProguardMapping.set(!System.getenv("SENTRY_AUTH_TOKEN").isNullOrBlank())
    includeProguardMapping.set(true)
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// Play rejects bundles signed with the debug certificate, but only after
// upload. Keep the local `flutter run --release` fallback above, and refuse to
// package a release bundle without release signing credentials.
val releaseSigningEnvironment = listOf(
    "ANDROID_KEYSTORE_PATH",
    "ANDROID_KEYSTORE_PASSWORD",
    "ANDROID_KEY_ALIAS",
    "ANDROID_KEY_PASSWORD",
)
// `bundleRelease` is only a lifecycle task, so guard the tasks that actually
// package and sign the variant.
tasks.matching { it.name.endsWith("ReleaseBundle") }
    .configureEach {
        doFirst {
            val missing = releaseSigningEnvironment.filter {
                System.getenv(it).isNullOrBlank()
            }
            check(missing.isEmpty()) {
                "Release bundles require signing credentials; missing: " +
                    missing.joinToString()
            }
        }
    }

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    testImplementation("junit:junit:4.13.2")
    testImplementation("org.robolectric:robolectric:4.16.1")
    testImplementation("org.mockito:mockito-core:5.0.0")
    testImplementation(project(":privy_flutter"))
}
