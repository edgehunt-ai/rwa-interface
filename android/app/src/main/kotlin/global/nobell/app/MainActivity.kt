package global.nobell.app

import android.app.UiModeManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Migrate an existing Flutter-only preference on the first native launch.
        // Android persists this override and uses it before starting the process
        // on subsequent launches, including for the Android 12 splash screen.
        val storedMode = getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
            .getString("flutter.app_theme_mode_v1", "system")
        applyLaunchThemeMode(storedMode)
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "global.nobell.app/appearance")
            .setMethodCallHandler { call, result ->
                if (call.method != "setThemeMode") {
                    result.notImplemented()
                } else if (call.arguments !in listOf("light", "dark", "system")) {
                    result.error("invalid_theme_mode", "Unknown appearance mode", null)
                } else {
                    applyLaunchThemeMode(call.arguments as String)
                    result.success(null)
                }
            }
    }

    private fun applyLaunchThemeMode(mode: String?) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) return
        val nightMode = when (mode) {
            "light" -> UiModeManager.MODE_NIGHT_NO
            "dark" -> UiModeManager.MODE_NIGHT_YES
            // AUTO clears the package override, so system appearance applies.
            else -> UiModeManager.MODE_NIGHT_AUTO
        }
        getSystemService(UiModeManager::class.java).setApplicationNightMode(nightMode)
    }
}
