import 'package:flappyBird/utils/utils.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final bool isStart;

  const MessageWidget({Key key, this.isStart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: isStart ? 0 : 1,
      child: Image.asset(
        AssetName.sprites.message,
      ),
    );
  }
}
