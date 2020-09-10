import 'dart:async';

import 'package:flappy/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Axis
  static double birdYaxis = 0, barrierX1 = 0;
  double time = 0,
      height = 0,
      initialHeight = birdYaxis,
      barrierX2 = barrierX1 + 2;
  bool isStartGame = false;
  // functions
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    isStartGame = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      setState(() {
        if (barrierX1 < -1.1) {
          barrierX1 += 2.2;
        } else {
          barrierX1 -= 0.5;
        }
      });
      setState(() {
        if (barrierX2 < -1.1) {
          barrierX2 += 2.2;
        } else {
          barrierX2 -= 0.5;
        }
      });
      if (birdYaxis > 1) {
        timer.cancel();
        isStartGame = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (birdYaxis < 1) {
                      if (isStartGame) {
                        jump();
                      } else {
                        startGame();
                      }
                    } else {
                      setState(() {
                        birdYaxis = 0;
                        time = 0;
                        height = 0;
                        initialHeight = birdYaxis;
                        isStartGame = false;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                ),
                // Container(
                //   alignment: Alignment(0, -0.3),
                //   child: isStartGame
                //       ? Text('')
                //       : Text(
                //           'TAP TO PLAY',
                //           style: TextStyle(color: Colors.white, fontSize: 25),
                //         ),
                // ),
                AnimatedContainer(
                  alignment: Alignment(barrierX1, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: Barrier(
                    size: 185.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierX1, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: Barrier(
                    size: 175.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierX2, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: Barrier(
                    size: 250.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierX2, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: Barrier(
                    size: 130.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}
