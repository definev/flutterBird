import 'dart:math';

import 'package:flappyBird/utils/utils.dart';
import 'package:flutter/material.dart';

class PipeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.rotate(
              angle: pi,
              child: Image.asset(
                AssetName.sprites.greenPipe,
              ),
            ),
            SizedBox(height: 100),
            Image.asset(
              AssetName.sprites.greenPipe,
            ),
          ],
        ),
      ),
    );
  }
}
