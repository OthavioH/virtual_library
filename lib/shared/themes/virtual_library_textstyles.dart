import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_library/shared/themes/virtual_library_colors.dart';

class VirtualLibraryTextStyles {
  static final TextStyle _defaultTextStyle = TextStyle(
    fontFamily: GoogleFonts.josefinSans().fontFamily,
    color: Colors.white,
  );

  static TextStyle appBarTitle = _defaultTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle selecedTabNavigationBarItem = _defaultTextStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: VirtualLibraryColors.appPrimaryColor,
  );

  static TextStyle unselectedTabNavigationBarItem =
      selecedTabNavigationBarItem.copyWith(
    color: Colors.white,
  );

  static TextStyle bookItemTitle = _defaultTextStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static TextStyle bookItemAuthor = _defaultTextStyle.copyWith(
    fontSize: 12,
  );
}
