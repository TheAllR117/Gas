import 'package:flutter/material.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class AppBarL {
  getAppBar(BuildContext context, bool back) {
    final uiProvider = Provider.of<UiProvider>(context);
    return AppBar(
      leading: (back)
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  if (uiProvider.selectViewInter == 0 &&
                      uiProvider.selectView == 0) {
                    uiProvider.selectView = uiProvider.selectView - 1;
                  } else if (uiProvider.selectViewInter > 0) {
                    uiProvider.selectViewInter = uiProvider.selectViewInter - 1;
                  } else {
                    uiProvider.selectView = 0;
                  }
                },
              ),
            )
          : null,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {}),
        )
      ],
      backgroundColor: Color.fromRGBO(245, 223, 76, 1.0),
      elevation: 0.0,
    );
  }
}
