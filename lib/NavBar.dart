import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';
import 'package:jwm2/Classes/Cart.dart';
import 'package:jwm2/Classes/Constants.dart';
import 'package:jwm2/Drawer/MainHome.dart';
import 'package:jwm2/OtherPages/CartPage.dart';
import 'package:jwm2/OtherPages/OrdersPage.dart';
import 'package:jwm2/OtherPages/ProfilePage.dart';

import 'Classes/Orders.dart';
import 'OtherPages/MorePage.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 1;

  final iconList = [
    TabItemIcon(iconData: Icons.home, curveColor: Colors.orange),
    TabItemIcon(iconData: Icons.shopping_cart, curveColor: Colors.green),
    TabItemIcon(iconData: Icons.list, curveColor: Colors.orange),
    TabItemIcon(iconData: Icons.settings, curveColor: Colors.green),
  ];
  void onChangeTab(int index) {
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: iconList.length,
      child: Scaffold(
        body: TabBarView(
          children: [MainHome(), CartPage(), OrdersPage(), MorePage()],
        ),
        bottomNavigationBar: JumpingTabBar(
          onChangeTab: onChangeTab,
          circleGradient: LinearGradient(
            colors: [
              kPrimaryColor,
              kWhiteColor,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          items: iconList,
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }
}
