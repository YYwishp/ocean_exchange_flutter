import 'dart:ui';

import 'package:decimal/decimal.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_exchange_flutter/common/model/price_entity.dart';
import 'package:ocean_exchange_flutter/common/utils/formart_num.dart';
import 'package:ocean_exchange_flutter/net/OceanApi.dart';
import 'package:ocean_exchange_flutter/common/utils/screen.dart';
import 'package:ocean_exchange_flutter/res/colors.dart';
import 'package:ocean_exchange_flutter/res/constant.dart';
import 'package:ocean_exchange_flutter/widget/MyCheckbox.dart';
import 'package:ocean_exchange_flutter/widget/RefreshLogo.dart';
import 'package:ocean_exchange_flutter/widget/push_to_refresh_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ocean_exchange_flutter/common/utils/theme_utils.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;

///
///
/// 资产页面
///
///
///
///
///
///
///

class FundsPages3 extends StatefulWidget {
  @override
  _FundsPages3State createState() => _FundsPages3State();
}

class _FundsPages3State extends State<FundsPages3>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin, TickerProviderStateMixin {
  late TabController tabController;

  String btcValue = "";
  String usdValue = "";

  var price_list = <PriceEntity>[];

  GlobalKey _showPercentCheckBoxKey = GlobalKey();

  DateTime lastRefreshTime = DateTime.now();

  late TabController primaryTC;
  final int _length2 = 50;


  final GlobalKey<PullToRefreshNotificationState> key = GlobalKey<PullToRefreshNotificationState>();



  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    primaryTC = TabController(length: 2, vsync: this);

    super.initState();

    print('FundsPages initState');

    this.tabController = TabController(length: 2, vsync: this);

    // key.currentState!.show(notificationDragOffset: 150);

    WidgetsBinding.instance?.addPostFrameCallback((mag) {
      print("===== 页面渲染完毕");

      Future.delayed(Duration(microseconds: 150),(){
        key.currentState!.show(notificationDragOffset: 80);
      });



    });

    WidgetsBinding.instance?.addPersistentFrameCallback((timeStamp){
      print(" =====================================实时 Frame 绘制回调 $timeStamp");
    });





  }

  @override
  void dispose() {
    primaryTC.dispose();
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('FundsPages build');






    var scaffold = Scaffold(
      body: _buildScaffoldBody(),
    );


    // key.currentState!.show(notificationDragOffset: 150);




    return scaffold;
  }



  Widget _buildScaffoldBody() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;

    return PullToRefreshNotification(
      key: key,
      color: Colors.blue,
      maxDragOffset: 80,

      onRefresh: () {
        // return Future<bool>.delayed(
        //   const Duration(
        //     seconds: 1,
        //   ),
        //   () {
        //     setState(
        //       () {
        //         _length1 += 10;
        //         lastRefreshTime = DateTime.now();
        //       },
        //     );
        //     return true;
        //   },
        // );

        return requestPrices();
      },
      child: extended.NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            ///title
            SliverAppBar(
              backgroundColor: Color(0xff0365d8),
              pinned: true,
              title: Text(
                '资产',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.access_time,
                      color: Colors.white,
                    ))
              ],
            ),

            /// 刷新头
            PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
              /*return SliverToBoxAdapter(
                child: PullToRefreshHeader(
                  info,
                  lastRefreshTime,
                  color: Colors.white,
                ),
              );*/

              final double offset = info?.dragOffset ?? 0.0;
              final Widget child = Container(
                alignment: Alignment.center,
                height: offset,
                width: double.infinity,
                child: RefreshLogo(
                  mode: info?.mode,
                  offset: offset,
                ),
              );

              return SliverToBoxAdapter(
                child: child,
              );
            }),

            /// 头部多少BTC
            SliverToBoxAdapter(
              child: Container(
                color: Color(0xff0365d8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    /// 是否显示
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "总资产估值",
                            style: TextStyle(color: Colors.white60),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.visibility_outlined,
                              color: Colors.white60,
                            ),
                          )
                        ],
                      ),
                    ),

                    /// 多少BTC
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 24, color: Colors.white),
                          children: <InlineSpan>[
                            TextSpan(
                              text: "${btcValue} BTC",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Condensed',
                                  letterSpacing: 1.2),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Text(
                                '  ≈ $usdValue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Condensed',
                                ),
                              ),
                            ),
                          ],
                        ),
                        // textAlign: TextAlign.center,
                      ),
                    ),

                    /// 3个按钮
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 7, 20),
                            child: ElevatedButton(
                              onPressed: () async {
                                var add = NumUtil.add(0.123450000000000001, 0.000000000112345);
                                print(add);

                                print(add.toDouble());
                                print(NumUtil.getNumByValueDouble(add.toDouble(), 4)!.toStringAsFixed(4));
                                var a = 0.123450000000000001;
                                var b = 0.000000000112345;
                                print(a.toString());
                                print(b.toString());

                                print('$a');
                                print('$b');

                                print(Decimal.parse(a.toString()) + Decimal.parse(b.toString())); // displays 0.3

                                var add1 = NumUtil.addDecStr('0.123450000000000001', '0.000000000112345');
                                print(add1);

                                Future<String>(() async {
                                  print("${DateTime.now()} 开始");

                                  await Future.delayed(Duration(seconds: 5));
                                  print("${DateTime.now()} 5秒过后");

                                  return "一个结果";
                                }).then((value) {
                                  print("${DateTime.now()} 返回 :$value");
                                }).whenComplete(() {
                                  print("${DateTime.now()} 完成");
                                });

                                print("${DateTime.now()} 这里没有等待");

                                String? aaaa = null;

                                print('======1');
                                print('===长度 ${aaaa?.length}');

                                print('======2');
                              },
                              child: Text('充值'),
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                // 圆角 边框
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                                backgroundColor: MaterialStateProperty.all(Color(0xff0365d8)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 7, 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('提现'),
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                // 圆角 边框
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                                backgroundColor: MaterialStateProperty.all(Color(0xff0365d8)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('划转'),
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                // 圆角 边框
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                                backgroundColor: MaterialStateProperty.all(Color(0xff0365d8)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// 买币卖币
            SliverToBoxAdapter(
              child: Container(
                height: 140,
                color: context.isDark ? Color(0xff000000) : Color(0xfff4f5f7),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: context.isDark ? Color(0xff101418) : Colors.white,
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              // 垂直 主轴（横向） 的排列方式
                              children: <Widget>[
                                SizedBox(
                                  child: AvdPicture.asset(
                                    'assets/images/icon_quick_money.xml',
                                  ),
                                  height: 36.h,
                                  width: 36.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '买币',
                                    style: TextStyle(fontSize: duSetFontSize(14)),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'SEPA; Visa/Master Card; IDeal',
                                style: TextStyle(fontSize: duSetFontSize(12)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        color: context.isDark ? Color(0xff101418) : Colors.white,
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              // 垂直 主轴（横向） 的排列方式
                              children: <Widget>[
                                SizedBox(
                                  //svg 直接使用android svg图
                                  child: AvdPicture.asset(
                                    'assets/images/ic_credit_card.xml',
                                  ),
                                  height: 36.h,
                                  width: 36.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '卖币',
                                    style: TextStyle(fontSize: duSetFontSize(14)),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                // '目前仅支持SEPA提现',
                                'At present, only SEPA withdrawal is supported',
                                style: TextStyle(fontSize: duSetFontSize(12)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },

        //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
        pinnedHeaderSliverHeightBuilder: () {
          return pinnedHeaderHeight;
        },

        //2.[inner scrollables in tabview sync issue](https://github.com/flutter/flutter/issues/21868)
        innerScrollPositionKeyBuilder: () {
          String index = 'Tab';

          index += primaryTC.index.toString();

          return Key(index);
        },

        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: TabBar(
                controller: primaryTC,

                //选中文字颜色context.isDark ? Colours.dark_text : Colors.black,
                labelColor: Color(0xff0365d8),

                // 下标颜色
                indicatorColor: Color(0xff0365d8),
                //指示器与文字等宽
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2.0,

                //可滚动，左对齐
                isScrollable: true,

                //未选中 文字颜色
                unselectedLabelColor: context.isDark ? Colours.dark_text : Colors.black,
                tabs: <Tab>[
                  Tab(
                    child: Text(
                      '币币账户',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '合约账户',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),

            /// 间隔 0xfff4f5f7
            Container(
              color: context.isDark ? Color(0xff000000) : Color(0xfff4f5f7),
              height: 1,
              width: double.infinity,
            ),

            Expanded(
              child: TabBarView(
                controller: primaryTC,
                children: <Widget>[
                  NestedScrollViewInnerScrollPositionKeyWidget(
                    const Key('Tab0'),
                    /*ListView.builder(
                      //store Page state
                      key: const PageStorageKey<String>('Tab0'),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext c, int i) {
                        return Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          child: Text(const Key('Tab0').toString() + ': ListView$i of $_length1'),
                        );
                      },
                      itemCount: _length1,
                      padding: const EdgeInsets.all(0.0),
                    ),*/
                    ExchangeBalancePage(
                      btcValue: btcValue,
                      usdValue: usdValue,
                      showPercentCheckBoxKey: _showPercentCheckBoxKey,
                    ),
                  ),
                  NestedScrollViewInnerScrollPositionKeyWidget(
                    const Key('Tab1'),
                    ListView.builder(
                      //store Page state
                      key: const PageStorageKey<String>('Tab1'),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext c, int i) {
                        return Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          child: Text(const Key('Tab1').toString() + ': ListView$i of $_length2'),
                        );
                      },
                      itemCount: _length2,
                      padding: const EdgeInsets.all(0.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// 请求接口
  ///
  Future<bool> requestPrices() async {
    try {
      print('--------------------------- requestPrice 请求 -------------------------');

      /// ========= requestPrice 请求 =========
      Map<String, dynamic> requestPrice = await OceanApi.requestPrice(context: context);

      price_list.clear();
      requestPrice.forEach((key, value) {
        // print('---- key = $key value = ${value}');

        price_list.add(PriceEntity(key, value));
      });

      /// ========= membersMe 请求 =========

      print('---------------------------  membersMe 请求 -------------------------');

      var fundsEntity = await OceanApi.membersMe(context: context);

      Decimal totalEquivalentBtc = Decimal.fromInt(0);

      fundsEntity.accounts?.forEach((element) {
        //累加
        totalEquivalentBtc = NumUtil.addDecStr(totalEquivalentBtc.toString(), element.btcEquivalentBalance!);
      });

      print('===值 ${totalEquivalentBtc.toString()}');

      setState(() {
        //直接截取8位，不四舍五入
        var formartNum2 = formartNum(totalEquivalentBtc.toString(), 8, isCrop: true);
        btcValue = formartNum2;

        for (var element in price_list) {
          if (element.id == "btc_usdt") {
            var usPrice = NumUtil.multiplyDecStr(btcValue, element.rate);

            //法币汇率
            var legalRate = Constant.findLegalTenders(Constant.current_LegalTender);

            if (legalRate != null) {
              var totalBtcUsPrice = NumUtil.multiplyDecStr(usPrice.toString(), legalRate.rate!);

              var formartNum2 = formartNum(totalBtcUsPrice.toString(), 2, isCrop: true);

              usdValue = formartNum2.toString() + Constant.current_LegalTender;
            }

            break;
          }
        }
      });

      return Future.value(true);
    } catch (e) {
      print("请求异常=== $e");
      return Future.value(true);
    }
  }
}

class ExchangeBalancePage extends StatefulWidget {
  final String btcValue;
  final String usdValue;
  final GlobalKey showPercentCheckBoxKey;

  Widget divider1 = Divider(
    height: 2.w,
    color: Color(0xfff4f5f7),
  );

  Widget divider2 = Divider(
    color: Colors.transparent,
  );

  ExchangeBalancePage({Key? key, required this.btcValue, required this.usdValue, required this.showPercentCheckBoxKey})
      : super(key: key);

  @override
  _ExchangeBalancePageState createState() => _ExchangeBalancePageState();
}

class _ExchangeBalancePageState extends State<ExchangeBalancePage> {
  bool invisibleChecked = true;

  @override
  Widget build(BuildContext context) {


    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15.w, 10.h, 0, 0.h),
            child: Text(
              '币币总资产',
              style: TextStyle(
                color: Color(0xffc0c0c0),
                fontSize: 13.sp,
              ),
            ),
          );
        } else if (index == 1) {
          /// 多少BTC
          return Container(
            alignment: AlignmentDirectional.topStart,
            padding: EdgeInsets.fromLTRB(15.w, 10.w, 0, 10.h),
            child: Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                children: <InlineSpan>[
                  TextSpan(
                    text: "${widget.btcValue} BTC",
                    style: TextStyle(
                      // fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Condensed',
                      // letterSpacing: 1,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(
                      '  ≈ ${widget.usdValue}',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Condensed',
                      ),
                    ),
                  ),
                ],
              ),
              // textAlign: TextAlign.center,
            ),
          );
        } else if (index == 2) {
          return Container(
            height: 10.h,
            color: context.isDark ? Color(0xff000000) : Color(0xfff4f5f7),
          );
        } else if (index == 3) {
          return Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Checkbox(
                  value: invisibleChecked,
                  onChanged: (value) {
                    setState(() {
                      invisibleChecked = value!;
                    });
                  },
                ),
              ),
              Text(
                '隐藏小额',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),

              // SizedBox(
              //   //svg 直接使用android svg图
              //   child: AvdPicture.asset(
              //     'assets/images/icon_percent_hide.xml',
              //   ),
              //   height: 18.h,
              //   width: 18.w,
              // ),

              Expanded(
                child: SizedBox(
                  height: 10,
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: MyCheckbox((value) {
                  print('===== 选中了么 $value');
                }, widget.showPercentCheckBoxKey),
              ),
            ],
          );
        } else {
          return Container(
            padding: EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 0.w),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('USD\$'),
                    Expanded(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    Text(
                      '0.0000000000',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.w),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text('0.0000000000'),
                )
              ],
            ),
          );
        }
      },
      separatorBuilder: (context, index) {
        if (index == 0) {
          return widget.divider2;
        } else if (index == 1) {
          return widget.divider2;
        } else if (index == 2) {
          return widget.divider2;
        } else if (index == 3) {
          return widget.divider2;
        } else {
          return widget.divider1;
        }
      },
      itemCount: 120,
    );

    /*return ListView.builder(
      //store Page state
      key: const PageStorageKey<String>('Tab0'),
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext c, int i) {
        return Container(
          alignment: Alignment.center,
          height: 60.0,
          child: Text(const Key('Tab0').toString() + ': ListView$i of '),
        );
      },
      itemCount: 120,
      padding: const EdgeInsets.all(0.0),
    );*/

    /*Widget redDivider = Divider(color: Colors.red);
    Widget blueDivider = Divider(color: Colors.blue);

    return ListView.separated(
      padding: EdgeInsets.all(0),

      itemCount: 50,
      //判断奇偶数进行分割线颜色处理
      separatorBuilder: (BuildContext context, int index){
        return index % 2 == 0 ? redDivider:blueDivider;
      },
      itemBuilder: (BuildContext context, int index){
        return ListTile(title: Text("我是列表$index"),);
      },
    );*/
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
