import 'dart:html';
import 'dart:math';

import 'package:flappyBird/utils/utils.dart';
import 'package:flappyBird/widgets/base_widget.dart';
import 'package:flappyBird/widgets/bird_widget.dart';
import 'package:flappyBird/widgets/message_widget.dart';
import 'package:flappyBird/widgets/pipe_widget.dart';
import 'package:flappyBird/widgets/position_anmated_custom.dart';
import 'package:flappyBird/widgets/score_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int pipe = 300;
  int highScore = 0;
  double height = 600;
  double width = 300;
  bool isEnd = false;
  bool isStart = false;
  bool isTap = false;
  bool init = false;

  FocusNode _spaceNode = FocusNode();
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

    setSpeed(12, 2);

    _animationController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isStart == true) {
          double speedPipe = getSpeedPipe();
          double collision = onCollision();
          _controller.jumpTo(speedPipe);

          if (speedPipe - collision <= 42 && speedPipe - collision >= -42) {
            isEndGame();
          } else if (speedPipe - collision > 42) currentPoint++;
          if (!isEnd) {
            currentOffset++;
          } else {
            isStart = false;
            isEnd = false;
          }
          if (_birdPos.pos == height - 130) {
            isStart = false;
            isEnd = false;
          }
        }
        setState(() {});
      });
    });
  }

  void isEndGame() {
    if (_birdPos.pos <= 315 + -100 * _ranNum[currentPoint] ||
        _birdPos.pos >= 390 + -100 * _ranNum[currentPoint]) {
      isEnd = true;
      if (highScore < currentPoint) {
        highScore = currentPoint;
      }
    }
  }

  double getSpeedPipe() =>
      ((_speedFactor.speedGame) * currentOffset).toDouble();

  double onCollision() =>
      (startOffset + 26 + (52 + 100) * (currentPoint)).toDouble();

  double birdPosition() {
    if (isStart == false) return height / 2 - 50;
    if (isTap) {
      return 0;
    } else {
      return height - 130;
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
      currentOffset = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.jumpTo(0);
      });
      FocusScope.of(context).requestFocus(_spaceNode);
    }

    return RawKeyboardListener(
      focusNode: _spaceNode,
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.logicalKey.keyId == KeyCode.SPACE &&
            event.runtimeType == RawKeyDownEvent) {
          if (isStart == false) isStart = true;
          isTap = true;
          Future.delayed(Duration(milliseconds: 150), () {
            isTap = false;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          if (isStart == false) isStart = true;
          isTap = true;
          Future.delayed(Duration(milliseconds: 150), () {
            isTap = false;
          });
        },
        child: Container(
          color: Colors.white,
          child: FittedBox(
            child: SizedBox(
              height: height,
              width: width,
              child: Container(
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
                      physics: NeverScrollableScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          pipe * 2,
                          (index) {
                            if (index == 0) {
                              return SizedBox(width: startOffset);
                            } else if (index % 2 == 0 && index != 0) {
                              return Transform.translate(
                                offset:
                                    Offset(0, -100 * _ranNum[(index - 2) ~/ 2]),
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
                      child: Opacity(
                        opacity: isStart ? 1 : 0,
                        child: BirdWidget(),
                      ),
                    ),
                    (isStart)
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
                      top: height - 100,
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
                    Center(
                      child: MessageWidget(
                        isStart: isStart,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 120),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: isStart ? 0 : 1,
                          child: ScoreWidget(
                            key: UniqueKey(),
                            score: highScore,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
