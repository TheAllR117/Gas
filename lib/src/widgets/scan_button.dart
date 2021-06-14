import 'package:flutter/material.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return FloatingActionButton(
      child: Icon(
        Icons.qr_code,
        color: Colors.black,
      ),
      onPressed: () {
        uiProvider.selectedMenuOpt = 2;
      },
      backgroundColor: Color.fromRGBO(245, 223, 77, 1.0),
      elevation: 0.0,
    );
  }
}
