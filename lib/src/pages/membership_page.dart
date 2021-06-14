import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
//import 'package:gasfast/src/helpers/helpers.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/services/auth_service.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:onesignal_flutter/onesignal_flutter.dart';

class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  //static final String oneSignalAppId = "dddb8413-d9ef-4f54-b747-fe0269bc21b8";
  final authService = new AuthService();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final size = MediaQuery.of(context).size;
    return FadeIn(
      child: Scaffold(
        appBar: AppBarL()
            .getAppBar(context, (uiProvider.selectView == 1) ? true : false),
        body: Stack(children: <Widget>[
          BackgroundP().crearFondo(context, 0.15),
          Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              (uiProvider.selectView == 1)
                                  ? 'Pago con envío'
                                  : 'Membresía',
                              style: TextStyle(
                                  fontSize: size.height * 0.035,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Card(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 25),
                width: size.width * 0.75,
                height: size.height * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: "${authService.userMain!.user!.membership}",
                      version: QrVersions.min,
                      size: size.width * 0.55,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: Text(
                        'Muestra tu QR al despachador para realizar pagos, facturas tus compras y sumar puntos.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: size.height * 0.018),
                      ),
                    )
                  ],
                ),
              )),
            )
          ]),
        ]),
      ),
    );
  }

  Future<void> initPlatformState() async {
    /*OneSignal.shared.init(oneSignalAppId);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      showConfirmePayment(
          context,
          '${notification.payload.additionalData['gasoline']}',
          '${notification.payload.additionalData['payment']}',
          '${notification.payload.additionalData['liters']}',
          '${notification.payload.additionalData['sale']}',
          '${notification.payload.additionalData['dispatcher_id']}',
          '${notification.payload.additionalData['no_bomb']}',
          '${notification.payload.additionalData['no_island']}');
    });*/
  }
}
