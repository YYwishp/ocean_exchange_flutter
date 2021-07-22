import 'dart:ui';

import 'package:decimal/decimal.dart';
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
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ocean_exchange_flutter/common/utils/theme_utils.dart';

/// 资产页面
///
///
///
///
///
///
///

class FundsPages2 extends StatefulWidget {
  @override
  _FundsPages2State createState() => _FundsPages2State();
}

class _FundsPages2State extends State<FundsPages2> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late TabController tabController;

  GlobalKey _refresherKey = GlobalKey();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // Header浮动
  bool _headerFloat = false;

  // 震动
  bool _vibration = true;

  String btcValue = "";
  String usdValue = "";

  var price_list = <PriceEntity>[];

  GlobalKey _showPercentCheckBoxKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    print('FundsPages initState');

    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print('FundsPages build');


    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Color(0xff0365d8),
        title: Text(
          '资产',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.access_time,
                color: Colors.white,
              ))
        ],
      ),
      body: SmartRefresher(
        key: _refresherKey,
        controller: _refreshController,
        enablePullUp: true,
        header: ClassicHeader(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        onRefresh: () async {
          //monitor fetch data from network
          await Future.delayed(Duration(milliseconds: 1000));
          print('========刷新');

          requestPrices();

          // if (mounted) setState(() {});
          // _refreshController.refreshCompleted();
        },
        onLoading: () async {
          //monitor fetch data from network
          await Future.delayed(Duration(milliseconds: 1000));
          print('========加载更多');
          if (mounted) setState(() {});
          // _refreshController.loadFailed();
          _refreshController.loadNoData();
        },
        child: CustomScrollView(
          slivers: [
            /*SliverAppBar(
            // floating: true,
            // snap: true,
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text("测试"),
              background: Image.network(
                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                fit: BoxFit.cover,
              ),
            ),


            // flexibleSpace: Container(
            //   color: Colors.deepOrange,
            //   height: double.infinity,
            //   child: Column(
            //     children: <Widget>[
            //       Text("测试"),
            //       Text("测试"),
            //       Text("测试"),
            //
            //     ],
            //   ),
            // ),
          ),*/
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

            ///固定高度的
            SliverPersistentHeader(
              //悬停
              pinned: true,
              floating: true,
              delegate: StickyTabBarDelegate(
                // 调整 TabBar 高度 ，用到 PreferredSize
                child: PreferredSize(
                  //必须包裹一层 Container 用于填充颜色，要不然背景居然是透明的
                  child: Container(
                    color: context.isDark ? Colours.dark_bg_color : Color(0xfff4f5f7),
                    child: TabBar(
                      //可滚动，左对齐
                      isScrollable: true,

                      //选中文字颜色context.isDark ? Colours.dark_text : Colors.black,
                      labelColor: Color(0xff0365d8),
                      //未选中 文字颜色
                      unselectedLabelColor: context.isDark ? Colours.dark_text : Colors.black,
                      // 下标颜色
                      indicatorColor: Color(0xff0365d8),
                      //指示器与文字等宽
                      // indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 2,
                      labelPadding: EdgeInsets.fromLTRB(15, 10, 10, 10),

                      // 用了这个 , indicatorSize: TabBarIndicatorSize.label, 就不和文字等长了=
                      indicatorPadding: EdgeInsets.fromLTRB(15, 0, 10, -1),

                      controller: tabController,
                      tabs: [
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
                  preferredSize: Size(double.infinity, 50),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                color: context.isDark ? Color(0xff000000) : Color(0xfff4f5f7),
                height: 1,
                width: 100,
              ),
            ),

            ///剩余补充内容
            SliverFillRemaining(
              hasScrollBody: true,
              child: TabBarView(
                controller: this.tabController,
                children: <Widget>[
                  Center(
                    child: ExchangeBalancePage(
                      btcValue: btcValue,
                      usdValue: usdValue,
                      showPercentCheckBoxKey: _showPercentCheckBoxKey,
                    ),
                  ),
                  Center(child: Text('Content of Profile')),
                ],
              ),
            ),

            // SliverFixedExtentList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) => Container(color: colorList[index]),
            //     childCount: colorList.length,
            //   ),
            //   itemExtent: 100,
            // ),
          ],
        ),
      ),
    );
  }

  void requestPrices() {
    Decimal totalEquivalentBtc = Decimal.fromInt(0);

    OceanApi.requestPrice(context: context).then((Map<String, dynamic> value) {
      // print('~~~:${value.toString()}');
      // var jsonEncode2 = jsonEncode(value);
      // print('>>>>>:$jsonEncode2');

      price_list.clear();
      value.forEach((key, value) {
        // print('---- key = $key value = ${value}');

        price_list.add(PriceEntity(key, value));
      });
      // list.forEach((element) {
      //   print('----element:${element.toString()}');
      // });
    }).whenComplete(() {
      OceanApi.membersMe(context: context).then((value) {
        // print('====${value.accounts}');

        value.accounts?.forEach((element) {
          //累加
          totalEquivalentBtc = NumUtil.addDecStr(totalEquivalentBtc.toString(), element.btcEquivalentBalance!);
        });

        print('===值${totalEquivalentBtc.toString()}');

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

              _refreshController.refreshCompleted();
              break;
            }
          }
        });

        // list
      }).onError((error, stackTrace) {
        print('-----membersMe error:$error');
        _refreshController.refreshCompleted();
      });
    }).onError((error, stackTrace) {
      _refreshController.refreshCompleted();
      print('-----requestPrice error:$error');
    });

    print('---------------------------  执行 -------------------------');
  }
}

class ExchangeBalancePage extends StatefulWidget {
  final String btcValue;
  final String usdValue;
  final GlobalKey showPercentCheckBoxKey;

  Widget divider1 = Divider(
    color: Colors.blue,
  );

  ExchangeBalancePage({Key? key, required this.btcValue, required this.usdValue, required this.showPercentCheckBoxKey})
      : super(key: key);

  @override
  _ExchangeBalancePageState createState() => _ExchangeBalancePageState();
}

class _ExchangeBalancePageState extends State<ExchangeBalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15.w, 14.h, 0, 0.h),
            child: Text(
              '币币总资产',
              style: TextStyle(
                color: Color(0xffc0c0c0),
                fontSize: 14.sp,
              ),
            ),
          ),

          /// 多少BTC
          Container(
            alignment: AlignmentDirectional.topStart,
            padding: EdgeInsets.fromLTRB(15.w, 10.w, 0, 15.h),
            child: Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
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
          ),

          Container(
            height: 10.h,
            color: context.isDark ? Color(0xff000000) : Color(0xfff4f5f7),
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Checkbox(
                  value: false,
                  onChanged: (value) {},
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
          ),
          // SliverList

          Container(
            height: 500,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Text(
                  '隐藏小额',
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return widget.divider1;
              },
              itemCount: 120,
            ),
          )

          // ListView.builder(
          //   itemBuilder: (context, index) {
          //     if (index == 1) {
          //       return Row(
          //         children: <Widget>[
          //           Checkbox(
          //             value: false,
          //             onChanged: (value) {},
          //           ),
          //         ],
          //       );
          //     } else {
          //       return Container(
          //         child: Column(
          //           children: <Widget>[],
          //         ),
          //       );
          //     }
          //   },
          //   itemCount: 10,
          // )
        ],
      ),
    );
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
