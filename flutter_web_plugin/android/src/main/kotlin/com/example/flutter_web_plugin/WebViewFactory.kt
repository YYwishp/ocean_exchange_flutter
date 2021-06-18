package com.example.flutter_web_plugin

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class WebViewFactory( var messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

	override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
		return FlutterWebView(context, messenger, id = viewId, args = args as Map<String, Any>?)

	}
}