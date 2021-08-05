import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/generated/l10n.dart';
import 'package:ocean_exchange_flutter/net/OceanApi.dart';
import 'package:ocean_exchange_flutter/page/funds/funds_page.dart';
import 'package:ocean_exchange_flutter/page/funds/funds_page2.dart';
import 'package:ocean_exchange_flutter/page/funds/funds_page3.dart';
import 'package:ocean_exchange_flutter/page/home/home_page.dart';
import 'package:ocean_exchange_flutter/page/markets/market_page.dart';
import 'package:ocean_exchange_flutter/page/swap_trades/swap_trades_page.dart';
import 'package:ocean_exchange_flutter/page/trades/trades_page.dart';
import 'package:ocean_exchange_flutter/common/utils/theme_utils.dart';
import 'package:ocean_exchange_flutter/res/constant.dart';
import 'package:ocean_exchange_flutter/routes/routes.dart';



class NavigationBarPageView extends StatefulWidget {
  @override
  _NavigationBarPageViewState createState() => _NavigationBarPageViewState();
}

class _NavigationBarPageViewState extends State<NavigationBarPageView> {
  late int _currentIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  List<BottomNavigationBarItem> getItems() {
    return [
      BottomNavigationBarItem(
          tooltip: '',
          icon: Image.asset(
            'assets/images/icon_home.png',
            width: 16,
            height: 16,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_home_pressed.png',
            width: 16,
            height: 16,
          ),
          label: S.of(context).home),
      BottomNavigationBarItem(
          tooltip: '',
          icon: Image.asset(
            'assets/images/icon_markets.png',
            width: 16,
            height: 16,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_markets_pressed.png',
            width: 16,
            height: 16,
          ),
          label: S.of(context).markets),
      BottomNavigationBarItem(
          tooltip: '',
          icon: Image.asset(
            'assets/images/icon_trades.png',
            width: 16,
            height: 16,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_trades_pressed.png',
            width: 16,
            height: 16,
          ),
          label: S.of(context).trades),
      BottomNavigationBarItem(
          tooltip: '',
          icon: Image.asset(
            'assets/images/icon_swap.png',
            width: 16,
            height: 16,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_swap_pressed.png',
            width: 16,
            height: 16,
          ),
          label: S.of(context).contract),
      BottomNavigationBarItem(
          tooltip: '',
          icon: Image.asset(
            'assets/images/icon_funds.png',
            width: 16,
            height: 16,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_funds_pressed.png',
            width: 16,
            height: 16,
          ),
          label: S.of(context).funds),
    ];
  }

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;

    _pages = [
      HomePage(),
      MarketsPage(),
      TradesPage(),
      SwapTradesPage(),
      // FundsPages()
      // FundsPages2()
      FundsPages3()
    ];

    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// =============== 请求法币的汇率
    OceanApi.legalTenders(context: context).then((value){
      print('----$value');

      Constant.setLegalTenders(value.data);

      if (Constant.current_LegalTender.isEmpty) {

        Constant.legalTenders.forEach((element) {
          if (element.code == "USD") {
            if (element.code!=null) {
              Constant.current_LegalTender = element.code!;
            }


            //保存到本地

            SpUtil.putObject(Constant.legal_tender, element);



          }
        });
      }




    });









    final bool isDark = context.isDark;

    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          return _pages[index];
        },
        //禁用滑动
        physics: NeverScrollableScrollPhysics(),
        // physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: _pageChange,
      ),
      bottomNavigationBar: Theme(
          data: ThemeData(
            // brightness: Brightness.light,
            // highlightColor: Colors.transparent,
            // splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: isDark?Color(0xff101418):Colors.white,
            selectedItemColor: Color(0xff005dcd),
            unselectedItemColor: Color(0xff6e7173),

            // fixedColor: Color.fromARGB(255, 0, 188, 96),
            type: BottomNavigationBarType.fixed,
            items: getItems(),
            currentIndex: _currentIndex,
            onTap: onTap,
          )),
    );
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void onTap(int index) {

    Constant.TOKEN = SpUtil.getString(Constant.token);

    if(Constant.TOKEN!.isEmpty && index ==4){
      Navigator.pushNamed(context, Routes.loginPage);

    }else{




      _pageController.jumpToPage(index);

      if(index == 4){
        if (Constant.isLogin()) {


          requestMembersProfile();

        }
      }


    }






  }

  Future<void> requestMembersProfile() async {
    print('=========请求开始===============');
    var membersProfile = await OceanApi.getMembersProfile(context: context);

    if(membersProfile.sn!=null){
      SpUtil.putString(Constant.sn, membersProfile.sn!);
    }

  }



}





























