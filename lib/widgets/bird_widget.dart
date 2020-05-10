import 'package:flappyBird/utils/utils.dart';
import 'package:flutter/material.dart';

class BirdWidget extends StatefulWidget {
  const BirdWidget({Key key}) : super(key: key);
  @override
  _BirdWidgetState createState() => _BirdWidgetState();
}

class _BirdWidgetState extends State<BirdWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        if (_animationController.value == 1) {
          _animationController.value = 0;
          _animationController.forward();
        }
        if (_animationController.value <= 1 / 3) {
          return Image.asset(
            AssetName.sprites.yellowBird.getUpFlap(),
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          );
        } else if (_animationController.value <= 2 / 3) {
          return Image.asset(
            AssetName.sprites.yellowBird.getMidFlap(),
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          );
        } else {
          return Image.asset(
            AssetName.sprites.yellowBird.getDownFlap(),
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          );
        }
      },
    );
  }
}
