import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasfast/src/bloc/map/map_bloc.dart';
import 'package:gasfast/src/bloc/search_map/search_map_bloc.dart';
import 'package:gasfast/src/bloc/my_location/my_location_bloc.dart';
import 'package:gasfast/src/bloc/pay/pay_bloc.dart';
import 'package:gasfast/src/pages/login_page.dart';
import 'package:gasfast/src/pages/home_page.dart';
import 'package:gasfast/src/bloc/providerP.dart';
import 'package:gasfast/src/pages/register_page.dart';
import 'package:gasfast/src/pages/validate_Token_page.dart';
import 'package:gasfast/src/services/stripe_service.dart';
import 'package:provider/provider.dart';
import 'src/providers/ui_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor:
          (Platform.isAndroid) ? Colors.transparent : Colors.black));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*final stripeService = new StripeService();
    stripeService.init();*/
    new StripeService()..init();
    return ProviderP(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => new UiProvider()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => PayBloc()),
            BlocProvider(create: (_) => MyLocationBloc()),
            BlocProvider(create: (_) => MapBloc()),
            BlocProvider(create: (_) => SearchMapBloc())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GasFast',
            initialRoute: 'validate',
            routes: {
              'login': (BuildContext context) => LoginPage(),
              'register': (BuildContext context) => RegisterPage(),
              'validate': (BuildContext context) => ValidateTokenPage(),
              'home': (BuildContext context) => HomePage(),
            },
            theme: ThemeData(
              primaryColor: Colors.black,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Colors.black,
                selectionColor: Colors.black26,
                selectionHandleColor: Colors.black,
              ),
              //scaffoldBackgroundColor: Color.fromRGBO(245, 223, 76, 1),
            ),
            //theme: ThemeData.dark(),
          ),
        ),
      ),
    );
  }
}
