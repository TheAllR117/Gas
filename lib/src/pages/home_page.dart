import 'package:flutter/material.dart';
import 'package:gasfast/src/pages/access_gps_page.dart';
import 'package:gasfast/src/pages/loading_page.dart';
import 'package:gasfast/src/pages/marker/test_marker.dart';
import 'package:gasfast/src/pages/membership_page.dart';
import 'package:gasfast/src/pages/moves/deposits_page.dart';
import 'package:gasfast/src/pages/moves/move_page.dart';
import 'package:gasfast/src/pages/moves/payments_page.dart';
import 'package:gasfast/src/pages/moves/transfers_page.dart';
import 'package:gasfast/src/pages/sendBalance/confirme_balance_page.dart';
import 'package:gasfast/src/pages/sendBalance/send_Balance_page.dart';
import 'package:gasfast/src/pages/sendBalance/send_balance_finished.dart';
import 'package:gasfast/src/pages/stripe/balance_page.dart';
import 'package:gasfast/src/pages/stripe/card_page.dart';
import 'package:gasfast/src/pages/stripe/finish_paymen_page.dart';
import 'package:gasfast/src/pages/welcome_page.dart';
import 'package:gasfast/src/pages/map_page.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/widgets/custom_navigatorbar.dart';
import 'package:gasfast/src/widgets/scan_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    //final uiProvider = Provider.of<UiProvider>(context);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: _HomePageBody(),
        bottomNavigationBar: CustomNavigationBar(),
        floatingActionButton: ScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return false;
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;
    final currentIndexInter = uiProvider.selectView;
    final currentIndexInterView = uiProvider.selectViewInter;

    switch (currentIndex) {
      case 0:
        uiProvider.selectedMenuOpt = 0;
        switch (currentIndexInter) {
          case 0:
            return WelcomePage();
          case 1:
            return MembershipPage();
          case 2:
            switch (currentIndexInterView) {
              case 0:
                return BalancePage();
              case 1:
                return CardPage();
              case 2:
                return FinishPaymentPage();
              default:
                return BalancePage();
            }

          case 3:
            switch (currentIndexInterView) {
              case 0:
                return SendBalancePage();
              case 1:
                return ConfirmeBalancePage();
              case 2:
                return SendBalamceFinishPage();
              default:
                return SendBalancePage();
            }

          default:
            return WelcomePage();
        }

      case 1:
        uiProvider.selectedMenuOpt = 1;
        switch (currentIndexInter) {
          case 1:
            return LoadingPage();
          case 2:
            return AccessGpsPage();
          case 3:
            return MapaPage();
          default:
            return LoadingPage();
        }

      //return MapaPage();

      case 2:
        uiProvider.selectedMenuOpt = 2;
        return MembershipPage();
      case 3:
        uiProvider.selectedMenuOpt = 3;
        switch (currentIndexInter) {
          case 0:
            switch (currentIndexInterView) {
              case 0:
                return MovePage();

              default:
                return MovePage();
            }

          case 1:
            switch (currentIndexInterView) {
              case 0:
                return DepositsPage();
              default:
                return DepositsPage();
            }

          case 2:
            switch (currentIndexInterView) {
              case 0:
                return TransfersPage();
              default:
                return TransfersPage();
            }

          case 3:
            switch (currentIndexInterView) {
              case 0:
                return PymentsPage();
              default:
                return PymentsPage();
            }

          default:
            return MovePage();
        }

      case 4:
        uiProvider.selectedMenuOpt = 4;
        return TestMarkerPage();
      default:
        uiProvider.selectedMenuOpt = 0;
        return WelcomePage();
    }
  }
}
