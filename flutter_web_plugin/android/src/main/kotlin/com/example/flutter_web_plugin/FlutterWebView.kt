package com.example.flutter_web_plugin

import android.content.Context
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.View
import android.webkit.*
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import org.json.JSONObject

/**
 *  自定义 PlatformView
 * @property webView WebView
 * @property methodChannel MethodChannel
 * @property uiThreadHandler Handler
 */
class FlutterWebView() : PlatformView, MethodChannel.MethodCallHandler {
	private lateinit var webView: WebView
	private lateinit var methodChannel: MethodChannel
	private val uiThreadHandler = Handler(Looper.getMainLooper())

	constructor(context: Context?, messenger: BinaryMessenger, id: Int, args: Map<String, Any>?) : this() {
		webView = WebView(context!!)
		webView.apply {
			webChromeClient = ChromeWebViewClient()
			webViewClient = WebViewCline()
			settings.apply {
				// enable Javascript
				javaScriptEnabled = true
				useWideViewPort = true
				loadWithOverviewMode = true
				domStorageEnabled = true
				//setSupportZoom(true)
				//builtInZoomControls = true
				//displayZoomControls = false // no zoom button
			}
		}
		methodChannel = MethodChannel(messenger, "plugins.gyx.views/webview_$id")
		methodChannel.setMethodCallHandler(this)
	}

	override fun getView(): View {
		return webView
	}

	override fun dispose() {
		webView.destroy()
	}

	override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
		when (call.method) {
			"setUrl" -> {
				setUrl(call, result)
			}
			else -> {
				result.notImplemented()
			}
		}
	}



	private fun setUrl(methodCall: MethodCall, result: MethodChannel.Result) {
		val url = methodCall.arguments as String
		//webView.loadUrl(url)
		loadUrlWithJs(webView, url)
		result.success(null)
	}

	//==================================================================================================================
	//=== 提供给JavaScript 调用的方法
	inner class JsObject() {
		@JavascriptInterface
		fun callbackHandler(data: String) {
			callback(data)
		}
	}

	private fun callback(data: String) {
		val json = JSONObject(data)
		val type = json.optString("type", "null")
		when (type) {
			"tencent" -> {
				val randStr = json.optString("randstr", "")
				val ticket = json.optString("ticket", "")
				var map = mapOf("randStr" to randStr, "ticket" to ticket)


				Log.e("腾讯数据", "${Thread.currentThread().name} ${map.toString()}")
				//eventSink?.success(map) 方法是向 Flutter 端发送数据，此方法必须在主线程执行：
				uiThreadHandler.post {
					FlutterWebPlugin.sendContent(map)

				}
			}
			"google" -> {
				val ticket = json.optString("ticket", "")
				var map = mapOf("randStr" to "", "ticket" to ticket)
				Log.e("google 数据", "9999${Thread.currentThread().name}--${map.toString()}")


				uiThreadHandler.post {
					FlutterWebPlugin.sendContent(map)

				}
			}
		}
	}

	private fun loadUrlWithJs(webView: WebView?, url: String) {
		webView?.addJavascriptInterface(JsObject(), "Android")
		webView?.loadUrl(url)
	}

	inner class WebViewCline : WebViewClient() {
		@RequiresApi(Build.VERSION_CODES.LOLLIPOP)
		override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
			view?.loadUrl(request?.url.toString())
			return true
		}
	}

	inner class ChromeWebViewClient : WebChromeClient() {
		override fun onProgressChanged(view: WebView?, newProgress: Int) {
		}
	}
}