import 'package:flutter/material.dart';

class EmptyFavoriteList extends StatelessWidget {
  const EmptyFavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'You don\'t have any favorite book yet',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
