package io.github.feeluown.FeelUOwnX

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.chaquo.python.Python
import com.chaquo.python.android.AndroidPlatform

class MainActivity: FlutterActivity() {
    private val pyRuntime = "io.github.feeluown/chaquopy"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, pyRuntime).setMethodCallHandler {
            call, _ ->
            if (call.method == "startPythonInstance") {
                startPythonInstance()
            }
            if (call.method == "startFuoDaemon") {
                startFuoDaemon()
            }
        }
    }

    private fun startPythonInstance() {
        if (!Python.isStarted()) {
            Python.start(AndroidPlatform(this));
        }
    }

    private fun startFuoDaemon() {
        Python.getInstance().getModule("feeluown.__main__").callAttr("main", "-nw", "-d");
    }
}
