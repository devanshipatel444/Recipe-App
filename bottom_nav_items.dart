import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> bottomNavBarItems = [
  BottomNavigationBarItem(
    label: 'Groceries',
    icon: Image.asset(
      'assets/groceryIcon.png', // Path to your custom PNG image
      width: 24.0, // Set the width
      height: 24.0, // Set the height
    ),
  ),
  BottomNavigationBarItem(
    label: 'Recipes',
    icon: Image.asset(
      'assets/recipe.jpg',
      width: 24.0,
      height: 24.0,
    ),
  ),
  BottomNavigationBarItem(
    label: 'Calendar',
    icon: Image.asset(
      'assets/calendar.png',
      width: 24.0,
      height: 24.0,
    ),
  )
];
