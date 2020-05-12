import 'package:flappyBird/utils/utils.dart';
import 'package:flappyBird/widgets/score_widget.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final bool isStart;
  final int score;
  const MessageWidget({Key key, this.isStart, this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: isStart ? 0 : 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetName.sprites.message,
          ),
          SizedBox(height: 30),
          ScoreWidget(
            score: score,
          ),
        ],
      ),
    );
  }
}
