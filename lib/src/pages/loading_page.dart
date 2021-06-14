import 'package:flutter/material.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/services/traffic_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
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
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        uiProvider.selectView = 3;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          } else {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    final trafficService = new TrafficService();
    final uiProvider = Provider.of<UiProvider>(context);

    final permisoGPS = await Permission.location.isGranted;

    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    await trafficService.getStations();

    //await Future.delayed(Duration(milliseconds: 1000));
    if (permisoGPS && gpsActivo) {
      uiProvider.selectView = 3;
      return '';
    } else if (!permisoGPS) {
      uiProvider.selectView = 2;
      return 'Es necesario el permiso del GPS';
    } else {
      uiProvider.selectView = 2;
      return 'Active el GPS';
    }
  }
}
