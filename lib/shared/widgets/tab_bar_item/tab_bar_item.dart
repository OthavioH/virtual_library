import 'package:flutter/material.dart';
import 'package:virtual_library/shared/themes/virtual_library_textstyles.dart';

class TabBarItem extends StatelessWidget {
  final String tabTitle;
  const TabBarItem({Key? key, required this.tabTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        tabTitle,
        style: VirtualLibraryTextStyles.tabNavigationBarItem,
      ),
    );
  }
}
