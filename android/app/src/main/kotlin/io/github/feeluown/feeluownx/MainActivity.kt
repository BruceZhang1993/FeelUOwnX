package io.github.feeluown.feeluownx

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.chaquo.python.Python
import com.chaquo.python.android.AndroidPlatform
import com.chaquo.python.PyObject

class MainActivity: FlutterActivity() {
    private val pyRuntime = "io.github.feeluown/chaquopy"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, pyRuntime).setMethodCallHandler {
            call, result ->
            if (call.method == "startFuoDaemon") {
                val stdout = startFuoDaemon()
                result.success(stdout)
            }
        }
    }

    private fun startFuoDaemon(): String {
        val thread = FuoDaemonThread(this)
        thread.start()
        return "done"
    }
}

class FuoDaemonThread(private var context: MainActivity) : Thread() {
    override fun run() {
        if (!Python.isStarted()) {
            Python.start(AndroidPlatform(this.context))
        }
        Python.getInstance().getModule("sys")["argv"]?.asList()?.add(PyObject.fromJava("-nw"))
        Python.getInstance().getModule("sys")["argv"]?.asList()?.add(PyObject.fromJava("-d"))
        Python.getInstance().getModule("feeluown.__main__").callAttr("main")
    }
}
