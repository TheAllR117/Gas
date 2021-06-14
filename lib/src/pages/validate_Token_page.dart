import 'package:flutter/material.dart';
import 'package:gasfast/src/services/auth_service.dart';
import 'package:lottie/lottie.dart';

class ValidateTokenPage extends StatelessWidget {
  //const ValidateTokenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Center(
              child: Lottie.asset('assets/lottie/oil.json',
                  width: size.width * 1.0, reverse: false),
            );
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = new AuthService();
    final authenticated = await authService.isLoggedIn();
    //print('prueba $authenticated');
    if (authenticated) {
      await Navigator.popAndPushNamed(context, 'home');
    } else {
      await Navigator.popAndPushNamed(context, 'login');
    }
  }
}
