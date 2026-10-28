package io.privy.privyflutter

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.MutableContextWrapper
import android.os.Bundle

/**
 * The SDK retains its initialization context for Credential Manager. Keep that
 * context stable while Flutter replaces Activities, and release detached ones.
 * Application services remain usable before Flutter attaches its first window.
 */
class PrivyActivityContext(applicationContext: Context) :
    MutableContextWrapper(applicationContext.applicationContext) {
    private val application = applicationContext.applicationContext

    fun attach(activity: Activity) {
        baseContext = activity
    }

    fun detach() {
        baseContext = application
    }

    private fun requireActivity(): Activity {
        val activity = baseContext as? Activity
        check(activity != null && !activity.isFinishing && !activity.isDestroyed) {
            "Authentication requires an active app window. Return to the app and try again."
        }
        return activity
    }

    override fun startActivity(intent: Intent) {
        requireActivity().startActivity(intent)
    }

    override fun startActivity(intent: Intent, options: Bundle?) {
        requireActivity().startActivity(intent, options)
    }

    companion object {
        private var instance: PrivyActivityContext? = null

        // PrivyManager is a process-wide singleton, so its retained context must
        // also survive Flutter engine replacement without retaining an Activity.
        @Synchronized
        fun get(context: Context): PrivyActivityContext =
            instance ?: PrivyActivityContext(context).also { instance = it }
    }
}
