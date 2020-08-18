import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loading_bar.dart';
import 'animated_shadow_logo.dart';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'app_colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Animation _colorAnimation;
  double animatedSize = 200;
  bool logoAnimationFinished = false;
  double belowIconShadow, topIconShadow;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.slowMiddle,
    );

    bgColorAnimation();

    Timer(Duration(seconds: 1), () {
      logoAnimation();
    });
  }

  void bgColorAnimation() {
    _colorAnimation = ColorTween(
      begin: backgroundColor1,
      end: backgroundColor2,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  void logoAnimation() {
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {
        if (animatedSize > MediaQuery.of(context).size.width / 4)
          animatedSize = -(_animation.value * 100) + 200;
      });
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(milliseconds: 500), () {
          setState(() {
            logoAnimationFinished = true;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: _colorAnimation.value,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: double.infinity,
              ),
              AnimatedShadowLogo(
                logoAnimationFinished: true,
                animatedSize: animatedSize,
              ),
              Container(
                child: logoAnimationFinished?TypewriterAnimatedTextKit(
                    repeatForever: false,
                    totalRepeatCount: 1,
                    speed: Duration(milliseconds: 300),
                    onTap: () {},
                    text: [
                      "SHOWOFF APP",
                    ],
                    textStyle: GoogleFonts.paytoneOne(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                    alignment:
                    AlignmentDirectional.topStart // or Alignment.topLeft
                ):null,
              ),
              Container(
                child: logoAnimationFinished?LoadingBar(startAnimation: true,):null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}