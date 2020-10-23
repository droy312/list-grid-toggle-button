import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// 37, 82, 253, 1
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final double size = 115;
  double smallSize = 10;

  final Color blue = Color.fromRGBO(37, 82, 253, 1);

  final int firstAnimationTime = 200;
  final int secondAnimationTime = 700;

  AnimationController animationController;
  AnimationController animationController2;

  bool isStartAnimation = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: secondAnimationTime));
    animationController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: firstAnimationTime));
  }

  Widget smallContainer(int index, double height) {
    return AnimatedContainer(
      duration: Duration(milliseconds: secondAnimationTime),
      width: smallSize,
      height: smallSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
      ),
    );
  }

  Widget lineContainer({double width}) {
    return Container(
      height: 10,
      width: width,
      decoration: BoxDecoration(  
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      )
    );
  }

  void startAnimation() {
    isStartAnimation = false;
    animationController2.forward();
    Timer(Duration(milliseconds: firstAnimationTime), () {
      animationController.forward();
      setState(() {
        smallSize = 25;
      });
    });
  }

  void reverseAnimation() {
    isStartAnimation = true;
    animationController.reverse();
    setState(() {
      smallSize = 10;
    });
    Timer(Duration(milliseconds: secondAnimationTime), () {
      animationController2.reverse();
    });
  }

  void animationFunction() {
    isStartAnimation ? startAnimation() : reverseAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: animationFunction,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: CurvedAnimation(
                    curve: Curves.bounceInOut,
                    parent: animationController,
                  ),
                  builder: (context, child) {
                    return Stack(
                      children: [
                        // small cubes
                        Positioned(
                          left: 30,
                          top: 30 + (0 * 15.0),
                          child: Transform(
                            transform: Matrix4.translationValues(
                                0, 30 * animationController.value, 0),
                            child: smallContainer(1, smallSize),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: 30 + (1 * 15.0),
                          child: Transform(
                            transform: Matrix4.translationValues(
                                30 * animationController.value,
                                15 * animationController.value,
                                0),
                            child: smallContainer(1, smallSize),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: 30 + (2 * 15.0),
                          child: Transform(
                            transform: Matrix4.translationValues(
                                30 * animationController.value,
                                -30 * animationController.value,
                                0),
                            child: smallContainer(1, smallSize),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: 30 + (3 * 15.0),
                          child: Transform(
                            transform: Matrix4.translationValues(
                                0, -45 * animationController.value, 0),
                            child: smallContainer(1, smallSize),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: CurvedAnimation(
                    curve: Curves.fastOutSlowIn,
                    parent: animationController2,
                  ),
                  builder: (context, child) {
                    return Stack(
                      children: [
                        // Long bars
                        Positioned(
                          left: 50,
                          top: 30 + (0 * 15.0),
                          child: lineContainer(
                            width: 35 * (1 - animationController2.value),
                          ),
                        ),
                        Positioned(
                          left: 50,
                          top: 30 + (1 * 15.0),
                          child: lineContainer(
                            width: 35 * (1 - animationController2.value),
                          ),
                        ),
                        Positioned(
                          left: 50 + (35 * animationController2.value),
                          top: 30 + (2 * 15.0),
                          child: lineContainer(
                            width: 35 * (1 - animationController2.value),
                          ),
                        ),
                        Positioned(
                          left: 50 + (35 * animationController2.value),
                          top: 30 + (3 * 15.0),
                          child: lineContainer(
                            width: 35 * (1 - animationController2.value),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
