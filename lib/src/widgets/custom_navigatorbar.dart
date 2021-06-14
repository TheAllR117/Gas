import 'package:flutter/material.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
        onTap: (value) {
          uiProvider.selectedMenuOpt = value;
          uiProvider.selectView = 0;
          uiProvider.selectViewInter = 0;
        },
        currentIndex: currentIndex,
        backgroundColor: uiProvider.selectedMenuOpt == 1 ? Colors.black : null,
        unselectedItemColor: Color.fromRGBO(66, 66, 66, 0.8),
        showSelectedLabels: false,
        fixedColor: Color.fromRGBO(245, 223, 77, 1.0),
        //selectedItemColor: Colors.yellow,
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.place_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.place_outlined, color: Colors.transparent),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.stay_current_portrait_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet_outlined), label: '')
        ]);
  }
}
