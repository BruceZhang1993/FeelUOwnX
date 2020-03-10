package io.github.feeluown.FeelUOwnX

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.chaquo.python.Python

class MainActivity: FlutterActivity() {
    private val PYRUNTIME = "io.github.feeluown/chaquopy"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "startPythonInstance") {
                startPython()
            }
        }
    }

    private fun startPython(): void {
        if (!Python.isStarted()) {
            Python.start(this);
        }
    }
}
