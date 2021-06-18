import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/page/funds/funds_page.dart';
import 'package:ocean_exchange_flutter/page/home/home_page.dart';
import 'package:ocean_exchange_flutter/page/markets/market_page.dart';
import 'package:ocean_exchange_flutter/page/swap_trades/swap_trades_page.dart';
import 'package:ocean_exchange_flutter/page/trades/trades_page.dart';

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
          label: '首页'),
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
          label: '行情'),
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
          label: '交易'),
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
          label: '合约'),
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
          label: '资产'),
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
      FundsPages()
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
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent),
          child: BottomNavigationBar(
            backgroundColor: Color(0xff101418),
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
    _pageController.jumpToPage(index);
  }
}
