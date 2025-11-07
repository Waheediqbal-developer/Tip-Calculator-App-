import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tip_calculator_app/providers/ThemeProvider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(onPressed: (){
      themeProvider.toggleTheme();
    },
    icon: themeProvider.isDark ? Icon(Icons.wb_sunny) : Icon(Icons.nightlight));
  }
}