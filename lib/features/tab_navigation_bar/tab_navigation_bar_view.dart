import 'package:flutter/material.dart';
import 'package:virtual_library/features/home/home_page_view.dart';
import 'package:virtual_library/shared/themes/virtual_library_textstyles.dart';

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
          title: const Text('Virtual Library',
              style: VirtualLibraryTextStyles.appBarTitle),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Books',
                  style: VirtualLibraryTextStyles.tabNavigationBarItem,
                ),
              ),
              Tab(
                child: Text(
                  'Favorites',
                  style: VirtualLibraryTextStyles.tabNavigationBarItem,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            HomePage(),
            Center(
              child: Text('Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
