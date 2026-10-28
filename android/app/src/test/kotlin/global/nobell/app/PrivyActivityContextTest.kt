package global.nobell.app

import android.app.Activity
import android.app.Application
import android.content.Intent
import android.os.Bundle
import android.util.AndroidRuntimeException
import io.privy.privyflutter.PrivyActivityContext
import io.privy.privyflutter.PrivyPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import org.junit.Assert.assertEquals
import org.junit.Assert.assertSame
import org.junit.Assert.assertThrows
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mockito.mock
import org.mockito.Mockito.`when`
import org.robolectric.Robolectric
import org.robolectric.RobolectricTestRunner
import org.robolectric.RuntimeEnvironment
import org.robolectric.Shadows.shadowOf
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28], application = Application::class)
class PrivyActivityContextTest {
    @Test
    fun credentialUiLaunchesFromAttachedActivityWithoutNewTaskFlag() {
        val activity = Robolectric.buildActivity(Activity::class.java).setup().get()
        val context = PrivyActivityContext(RuntimeEnvironment.getApplication())
        context.attach(activity)

        val intent = Intent(activity, Activity::class.java)
        // This is the launch that Credential Manager attempts. The original
        // Application context fails because the UI must belong to an Activity.
        assertThrows(AndroidRuntimeException::class.java) {
            activity.applicationContext.startActivity(intent)
        }
        context.startActivity(intent)
        assertSame(intent, shadowOf(activity).nextStartedActivity)
        assertEquals(0, intent.flags and Intent.FLAG_ACTIVITY_NEW_TASK)

        context.startActivity(intent, Bundle())
        assertSame(intent, shadowOf(activity).nextStartedActivity)
    }

    @Test
    fun detachReleasesOldActivityAndReattachRoutesToNewWindow() {
        val application = RuntimeEnvironment.getApplication()
        val context = PrivyActivityContext(application)
        val old = Robolectric.buildActivity(Activity::class.java).setup()
        context.attach(old.get())
        context.detach()
        old.pause().stop().destroy()
        assertSame(application, context.baseContext)

        val next = Robolectric.buildActivity(Activity::class.java).setup().get()
        context.attach(next)
        val intent = Intent(next, Activity::class.java)
        context.startActivity(intent)
        assertSame(intent, shadowOf(next).nextStartedActivity)
    }

    @Test
    fun uiLaunchWithoutActivityPreservesActionableFailure() {
        val context = PrivyActivityContext(RuntimeEnvironment.getApplication())
        val error = assertThrows(IllegalStateException::class.java) {
            context.startActivity(Intent())
        }
        assertEquals(
            "Authentication requires an active app window. Return to the app and try again.",
            error.message,
        )
        assertThrows(IllegalStateException::class.java) {
            context.startActivity(Intent(), Bundle())
        }
    }

    @Test
    fun destroyedAndFinishingActivitiesCannotLaunchCredentialUi() {
        val context = PrivyActivityContext(RuntimeEnvironment.getApplication())
        val controller = Robolectric.buildActivity(Activity::class.java).setup()
        context.attach(controller.get())
        controller.get().finish()
        assertThrows(IllegalStateException::class.java) {
            context.startActivity(Intent())
        }
        controller.pause().stop().destroy()
        assertThrows(IllegalStateException::class.java) {
            context.startActivity(Intent())
        }
    }

    @Test
    fun sdkAndReplacementEngineShareTheSameContext() {
        val first = PrivyActivityContext.get(RuntimeEnvironment.getApplication())
        // Robolectric creates a fresh Application for each test; the SDK's
        // process-wide singleton retains the Application used by its first init.
        val application = first.applicationContext
        val activity = Robolectric.buildActivity(Activity::class.java).setup().get()
        first.attach(activity)
        assertSame(first, PrivyActivityContext.get(activity))
        first.detach()
        assertSame(application, first.baseContext)
        assertSame(first, PrivyActivityContext.get(application))
    }

    @Test
    fun flutterPluginUpdatesSdkContextAcrossConfigurationAndEngineChanges() {
        val context = PrivyActivityContext.get(RuntimeEnvironment.getApplication())
        val application = context.applicationContext
        val engine = mock(FlutterPluginBinding::class.java)
        `when`(engine.applicationContext).thenReturn(application)
        `when`(engine.binaryMessenger).thenReturn(mock(BinaryMessenger::class.java))
        val plugin = PrivyPlugin()
        plugin.onAttachedToEngine(engine)
        val binding = mock(ActivityPluginBinding::class.java)
        val first = Robolectric.buildActivity(Activity::class.java).setup().get()
        `when`(binding.activity).thenReturn(first)
        plugin.onAttachedToActivity(binding)
        assertSame(first, context.baseContext)

        plugin.onDetachedFromActivityForConfigChanges()
        assertSame(application, context.baseContext)
        val next = Robolectric.buildActivity(Activity::class.java).setup().get()
        `when`(binding.activity).thenReturn(next)
        plugin.onReattachedToActivityForConfigChanges(binding)
        assertSame(next, context.baseContext)

        plugin.onDetachedFromActivity()
        assertSame(application, context.baseContext)
        plugin.onAttachedToActivity(binding)
        plugin.onDetachedFromEngine(engine)
        assertSame(application, context.baseContext)
    }
}
