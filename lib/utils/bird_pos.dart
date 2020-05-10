import 'package:flutter/material.dart';

class BirdPos extends ChangeNotifier {
  double _pos = 0;

  double get pos => _pos;

  chagePos(double pos) {
    _pos = pos;
    notifyListeners();
  }

  chagePosNotListeners(double pos) {
    _pos = pos;
  }
}
