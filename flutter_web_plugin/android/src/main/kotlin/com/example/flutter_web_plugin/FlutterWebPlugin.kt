package com.example.flutter_web_plugin

import android.os.Handler
import android.util.Log
import android.webkit.WebView
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** FlutterWebPlugin */
class FlutterWebPlugin : FlutterPlugin, MethodCallHandler {
	private lateinit var webView: WebView

	/// The MethodChannel that will the communication between Flutter and native Android
	///
	/// This local reference serves to register the plugin with the Flutter Engine and unregister it
	/// when the Flutter Engine is detached from the Activity
	private lateinit var methodChannel: MethodChannel

	companion object {
		private const val METHOD_CHANNEL = "com.example.flutter_web_plugin/method_channel"
		private const val EVENT_CHANNEL = "com.example.flutter_web_plugin/event_channel"
		var eventSink: EventSink? = null

		fun sendContent(content:Any) {
			eventSink?.success(content);
		}


		// This static function is optional and equivalent to onAttachedToEngine. It supports the old
		// pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
		// plugin registration via this function while apps migrate to use the new Android APIs
		// post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
		//
		// It is encouraged to share logic between onAttachedToEngine and registerWith to keep
		// them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
		// depending on the user's project. onAttachedToEngine or registerWith must both be defined
		// in the same class.
		@JvmStatic
		fun registerWith(registrar: PluginRegistry.Registrar) {
			val channel = MethodChannel(registrar.messenger(), "custom_platform_view")
			channel.setMethodCallHandler(FlutterWebPlugin())

			registrar
					.platformViewRegistry()
					.registerViewFactory(
							"plugins.gyx.views/webview",
							WebViewFactory(registrar.messenger()))
		}






	}

	private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding


	override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

		// == 注册 Android 平台 控件
		flutterPluginBinding.platformViewRegistry.registerViewFactory("plugins.gyx.views/webview", WebViewFactory(flutterPluginBinding.binaryMessenger))
		//<editor-fold desc="==== Dart 调用原生">
		// 创建MethodChannel，必须跟flutter中使用相同的注册字符串
		methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL)
		// 设置MethodCallHander，methodCall中传递来自flutter的参数
		methodChannel.setMethodCallHandler(this)
		//</editor-fold>
		this.flutterPluginBinding = flutterPluginBinding
		// 1，创建 EventChannel 注册“包名/标识符”的channel名，通过EventChannel#setStreamHandler注册Handler实现
		var eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, EVENT_CHANNEL)
		eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
			override fun onListen(arguments: Any?, events: EventSink?) {
				//2,初始化完成后，获取eventSink引用并保存
				Log.e("EVENT_CHANNEL", "插件 初始化")
				eventSink = events

				//=== 测试用
				//Handler().postDelayed({
				//	// 3,eventSink发送事件通知
				//	eventSink?.success("我是原生 传递 的信息")
				//	// 4,通知结束时调用event#endOfStream，此时onCancel会被调用
				//	//eventSink?.endOfStream()
				//	// 5,必要时，可通过evnetSink#error发送错误通知，flutter的StreamSubscription#onError会收到通知
				//	//eventSink?.error("error code", "error message","error details")
				//}, 4000)
			}

			override fun onCancel(arguments: Any?) {
				eventSink = null
			}
		})
	}

	/**
	 *
	 * @param call MethodCall
	 * @param result Result
	 */
	override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
		if (call.method == "getPlatformVersion") {
			result.success("Android ${android.os.Build.VERSION.RELEASE}")
		} else if (call.method == "showToast") {
			val arguments = call.argument<String>("messages").toString()

			Toast.makeText(flutterPluginBinding.applicationContext, "调用原生代码，显示 flutter 传递的数据 $arguments", Toast.LENGTH_SHORT).show()

			result.success("原生 返回的数据")
		} else {
			result.notImplemented()
		}
	}

	override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
		methodChannel.setMethodCallHandler(null)
	}
}
