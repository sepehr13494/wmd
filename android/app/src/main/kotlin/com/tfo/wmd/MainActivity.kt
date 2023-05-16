// package com.tfo.wmd
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.provider.Settings;

class MainActivity: FlutterActivity() {
  private val channelName = "adb"

  override fun configureFlutterEngine( flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine);

    var channel MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName);

    channel.setMethodCallHandler { call, result ->
        if (call.method == "adbChecking") {
            checkingadb(result);
        } else {
            result.notImplemented();
        }
    }
  }

    private fun checkingadb(result: MethodChannel.Result) {
        if (Settings.Secure.getInt(this.getContentResolver(), Settings.Secure.ADB_ENABLED, 0) == 1) {
            // debugging enabled
            result.success(1);
        } else {
            //;debugging does not enabled
            result.success(0);
        }
    }
}



// import androidx.annotation.NonNull
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.MethodChannel

// class MainActivity: FlutterActivity() {
//   private val CHANNEL = "adb"

//   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//     super.configureFlutterEngine(flutterEngine)
//     MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//       call, result ->
//         if (call.method.equals("checkingadb")) {
//             checkingadb(call,result);
//         } else {
//             result.notImplemented();
//         }
//     }
//   }

//       private fun checkingadb(): Int {
//            if (Settings.Secure.getInt(this.getContentResolver(), Settings.Secure.ADB_ENABLED, 0) == 1) {
//             // debugging enabled
//             return 1;
//         } else {
//             //;debugging does not enabled
//             return 0;
//         }
//       }
// }
