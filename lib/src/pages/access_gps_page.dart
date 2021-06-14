import 'package:flutter/material.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AccessGpsPage extends StatefulWidget {
  @override
  _AccessGpsPageState createState() => _AccessGpsPageState();
}

class _AccessGpsPageState extends State<AccessGpsPage>
    with WidgetsBindingObserver {
  bool popup = false;
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final uiProvider = Provider.of<UiProvider>(context);
    if (state == AppLifecycleState.resumed && !popup) {
      if (await Permission.location.isGranted) {
        uiProvider.selectView = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el GPS para usar este apartado'),
            MaterialButton(
                child: Text(
                  'Solicitar Acceso',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                shape: StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                onPressed: () async {
                  popup = true;
                  final status = await Permission.location.request();
                  this.accessGPS(status, context, uiProvider);
                  popup = false;
                })
          ],
        ),
      ),
    );
  }

  void accessGPS(
      PermissionStatus status, BuildContext context, UiProvider uiProvider) {
    switch (status) {
      case PermissionStatus.granted:
        uiProvider.selectView = 1;
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        openAppSettings();
    }
  }
}
