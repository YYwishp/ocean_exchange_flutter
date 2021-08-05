import 'dart:math';
import 'dart:ui' as ui show Image;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:ocean_exchange_flutter/widget/nested_refresh/pull_to_refresh_notification.dart';

double get maxDragOffset => 100;
double hideHeight = maxDragOffset / 1.7;
double refreshHeight = maxDragOffset / 1.5;

class PullToRefreshHeader extends StatelessWidget {
  const PullToRefreshHeader(this.info, this.lastRefreshTime, {required this.color});
  final PullToRefreshScrollNotificationInfo? info;
  final DateTime lastRefreshTime;
  final Color color;
  @override
  Widget build(BuildContext context) {
    if (info == null) {
      return Container();
    }
    String text = '';
    if (info?.mode == RefreshIndicatorMode.armed) {
      text = 'Release to refresh';
    } else if (info?.mode == RefreshIndicatorMode.refresh ||
        info?.mode == RefreshIndicatorMode.snap) {
      text = 'Loading...';
    } else if (info?.mode == RefreshIndicatorMode.done) {
      text = 'Refresh completed.';
    } else if (info?.mode == RefreshIndicatorMode.drag) {
      text = 'Pull to refresh';
    } else if (info?.mode == RefreshIndicatorMode.canceled) {
      text = 'Cancel refresh';
    }
    else if (info?.mode == RefreshIndicatorMode.error) {
      text = 'Refresh error';
    }

    final TextStyle ts = const TextStyle(
      color: Colors.grey,
    ).copyWith(fontSize: 14);

    final double dragOffset = info?.dragOffset ?? 0.0;
    // print('-----dragOffset $dragOffset ');

    final DateTime time = lastRefreshTime;
    final double top = -hideHeight + dragOffset;

    return Container(
      height: dragOffset,
      color: color ,
      // padding: EdgeInsets.only(top: dragOffset / 3),
      // padding: EdgeInsets.only(bottom: 5.0),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            top: top,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: RefreshImage(top),
                    margin: const EdgeInsets.only(right: 12.0),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      text,
                      style: ts,
                    ),
                    Text(
                      'Last updated:' +
                          DateFormat('yyyy-MM-dd hh:mm').format(time),
                      style: ts.copyWith(fontSize: 14),
                    )
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          )
        ],
      ),
    );
    /*return Container(
      height: dragOffset,
      color: color ,
      //padding: EdgeInsets.only(top: dragOffset / 3),
      //padding: EdgeInsets.only(bottom: 5.0),
      child:Column(
        children: <Widget>[

          RefreshImage(top),
          Text(
            text,
            style: ts,
          ),
          Text(
            'Last updated:' +
                DateFormat('yyyy-MM-dd hh:mm').format(time),
            style: ts.copyWith(fontSize: 14),
          )
        ],
      ),
    );*/
  }
}

class RefreshImage extends StatelessWidget {
  const RefreshImage(this.top);
  final double top;
  @override
  Widget build(BuildContext context) {
    const double imageSize = 40;
    return ExtendedImage.asset(
      // 'assets/images/icon_swap_more.png',
      'assets/images/flutterCandies_grey.png',
      // 'assets/images/oceanex_logo.png',
      width: imageSize,
      height: imageSize,
      afterPaintImage: (Canvas canvas, Rect rect, ui.Image image, Paint paint) {
        final double imageHeight = image.height.toDouble();
        final double imageWidth = image.width.toDouble();
        final Size size = rect.size;
        final double y = (1 - min(top / (refreshHeight - hideHeight), 1)) * imageHeight;

        canvas.drawImageRect(
            image,
            Rect.fromLTWH(0.0, y, imageWidth, imageHeight - y),
            Rect.fromLTWH(rect.left, rect.top + y / imageHeight * size.height,
                size.width, (imageHeight - y) / imageHeight * size.height),
            Paint()
              ..colorFilter =
                  const ColorFilter.mode(Color(0xFFea5504), BlendMode.srcIn)
              ..isAntiAlias = false
              ..filterQuality = FilterQuality.low);

        //canvas.restore();
      },
    );
  }
}
