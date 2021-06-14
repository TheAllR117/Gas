import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  // mostrar/ocular contraseña login
  bool _showHide = true;

  bool get showHide {
    return this._showHide;
  }

  set showHide(bool i) {
    this._showHide = i;
    notifyListeners();
  }

  // cambiar la seleccion tabbar
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    notifyListeners();
  }

  // cambiar vista internamente
  int _selectView = 0;

  int get selectView {
    return this._selectView;
  }

  set selectView(int i) {
    this._selectView = i;
    notifyListeners();
  }

  // cambiar vista internamente
  int _selectViewInter = 0;

  int get selectViewInter {
    return this._selectViewInter;
  }

  set selectViewInter(int i) {
    this._selectViewInter = i;
    notifyListeners();
  }

  // cambiar steper
  int _step = 0;

  int get step {
    return this._step;
  }

  set step(int i) {
    this._step = i;
    notifyListeners();
  }

  // cambiar segment
  String _segment = 'all';

  String get segment {
    return this._segment;
  }

  set segment(String i) {
    this._segment = i;
    notifyListeners();
  }
}
