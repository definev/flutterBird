import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int score;
  final bool isStart;
  const ScoreWidget({Key key, this.score, this.isStart}) : super(key: key);

  List<int> splitScore() {
    int subScore = score;
    List<int> res = [];
    while (subScore >= 10) {
      res.add(subScore % 10);
      subScore = (subScore - subScore % 10) ~/ 10;
    }
    res.add(subScore);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    if (score < 10) {
      return Image.asset('assets/sprites/$score.png');
    } else {
      List<int> _score = splitScore();
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _score.length,
          (index) => Image.asset(
              'assets/sprites/${_score[_score.length - index - 1]}.png'),
        ),
      );
    }
  }
}
