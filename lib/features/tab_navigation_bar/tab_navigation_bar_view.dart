import 'package:flutter/material.dart';
import 'package:virtual_library/features/favorites_page/favorites_page_view.dart';
import 'package:virtual_library/features/home/home_page_view.dart';
import 'package:virtual_library/shared/themes/virtual_library_colors.dart';
import 'package:virtual_library/shared/themes/virtual_library_textstyles.dart';
import 'package:virtual_library/shared/widgets/tab_bar_item/tab_bar_item.dart';

class TabNavigationBar extends StatefulWidget {
  const TabNavigationBar({super.key});

  @override
  State<TabNavigationBar> createState() => _TabNavigationBarState();
}

class _TabNavigationBarState extends State<TabNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Virtual Library',
            style: VirtualLibraryTextStyles.appBarTitle,
          ),
          centerTitle: true,
          backgroundColor: VirtualLibraryColors.appPrimaryColor,
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 5,
                color: VirtualLibraryColors.tabBarIndicatorColors,
              ),
            ),
            tabs: <Widget>[
              TabBarItem(tabTitle: 'Books'),
              TabBarItem(tabTitle: 'Favorites'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            HomePage(),
            FavoritesPage(),
          ],
        ),
      ),
    );
  }
}
