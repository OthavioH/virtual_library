extension StringExtensions on String {
  String removeAnySpecialCharacters() {
    final textWithoutSpecialCharacters = replaceAll(RegExp(r'[^\w\s]+'), '');
    final textWithoutSpaces = textWithoutSpecialCharacters.replaceAll(' ', '-');
    return textWithoutSpaces;
  }
}
