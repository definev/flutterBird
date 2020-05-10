import 'dart:math';

import 'package:flappyBird/utils/bird_pos.dart';
import 'package:flappyBird/utils/speed_factor.dart';
import 'package:flappyBird/utils/utils.dart';
import 'package:flappyBird/widgets/base_widget.dart';
import 'package:flappyBird/widgets/bird_widget.dart';
import 'package:flappyBird/widgets/message_widget.dart';
import 'package:flappyBird/widgets/pipe_widget.dart';
import 'package:flappyBird/widgets/position_anmated_custom.dart';
import 'package:flappyBird/widgets/score_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  ScrollController _controller = ScrollController(keepScrollOffset: true);
  int currentPoint = 0;
  int currentOffset = 0;
  double startOffset = 200;
  int pipe = 200;
  bool isEnd = false;
  bool isStart = false;
  bool isTap = false;
  bool init = false;

  SpeedFactor _speedFactor = SpeedFactor();
  BirdPos _birdPos;
  Random random = Random();
  List<double> _ranNum;

  void setSpeed(double velocity, double speedGame) {
    _speedFactor.velocity = velocity;
    _speedFactor.speedGame = speedGame;
  }

  void setVelocity(double velocity) => _speedFactor.velocity = velocity;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animationController.forward();
    _ranNum = List.generate(pipe, (index) => random.nextDouble());

    setSpeed(10, 2);

    _animationController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isStart == true) {
          _controller.jumpTo(getSpeedPipe());
          if (onCollision() - getSpeedPipe() <= 25) {
            if (isEndGame()) {
            } else
              currentPoint++;
          }
          if (!isEnd) {
            currentOffset++;
          } else {
            isStart = false;
            isEnd = false;
          }
        }

        setState(() {});
      });
    });
  }

  bool isEndGame() {
    if (_birdPos.pos <= 320 + -100 * _ranNum[currentPoint] ||
        _birdPos.pos >= 420 + -100 * _ranNum[currentPoint]) {
      isEnd = true;
      return true;
    } else {
      return false;
    }
  }

  double getSpeedPipe() =>
      ((_speedFactor.speedGame) * currentOffset).toDouble();

  double onCollision() =>
      (startOffset + 52 + (52 + 100) * (currentPoint)).toDouble();

  double birdPosition() {
    if (isStart == false) return MediaQuery.of(context).size.height / 2 - 50;
    if (isTap) {
      return 0;
    } else {
      return MediaQuery.of(context).size.height - 130;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (init == false) {
      _birdPos = Provider.of<BirdPos>(context);
      init = true;
    }
    if (isStart == false && isEnd == false) {
      currentPoint = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.jumpTo(0);
      });
    }

    return GestureDetector(
      onTap: () {
        print(_birdPos.pos);
        if (isStart == false) {
          setState(() {
            isStart = true;
          });
        }
        isTap = true;
        Future.delayed(Duration(milliseconds: 150), () {
          isTap = false;
        });
      },
      child: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            height: 1920,
            width: 1080,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetName.sprites.backgroundDay,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  // physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    children: List.generate(
                      pipe,
                      (index) {
                        if (index == 0) {
                          return SizedBox(width: startOffset);
                        } else if (index % 2 == 0 && index != 0) {
                          return Transform.translate(
                            offset: Offset(0, -100 * _ranNum[(index - 2) ~/ 2]),
                            child: PipeWidget(),
                          );
                        } else {
                          return SizedBox(width: 100);
                        }
                      },
                    ),
                  ),
                ),
                AnimatedPositionedCustom(
                  duration: Duration(milliseconds: 2500),
                  left: 80,
                  top: birdPosition(),
                  child: BirdWidget(),
                ),
                Center(
                  child: MessageWidget(
                    isStart: isStart,
                  ),
                ),
                isStart
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 500),
                        child: Center(
                          child: ScoreWidget(
                            score: currentPoint,
                            isStart: isStart,
                          ),
                        ),
                      )
                    : Container(),
                Positioned(
                  top: MediaQuery.of(context).size.height - 100,
                  child: Builder(
                    builder: (context) {
                      if (_animationController.value == 1) {
                        _animationController.value = 0;
                        _animationController.forward();
                      }
                      return BaseWidget(value: _animationController.value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
