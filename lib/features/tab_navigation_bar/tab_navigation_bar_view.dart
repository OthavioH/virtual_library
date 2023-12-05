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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            title: Center(
              child: Text(
                'Virtual Library',
                style: VirtualLibraryTextStyles.appBarTitle,
                textAlign: TextAlign.center,
              ),
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            backgroundColor: VirtualLibraryColors.appPrimaryColor,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicator: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  color: VirtualLibraryColors.white,
                ),
                labelStyle:
                    VirtualLibraryTextStyles.selecedTabNavigationBarItem,
                unselectedLabelStyle:
                    VirtualLibraryTextStyles.unselectedTabNavigationBarItem,
                tabs: const [
                  Tab(
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34),
                        child: Text(
                          'Books',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34),
                        child: Text(
                          'Favorites',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            HomePage(),
            FavoritesPage(),
          ],
        ),
      ),
    );
  }
}
