import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedShadowLogo extends StatefulWidget {

  final bool logoAnimationFinished;
  final double animatedSize;

  const AnimatedShadowLogo({this.logoAnimationFinished=false, this.animatedSize=200});

  @override
  _AnimatedShadowLogoState createState() => _AnimatedShadowLogoState();
}

class _AnimatedShadowLogoState extends State<AnimatedShadowLogo> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  double lowerAnimatedShadow=0.0,topAnimatedShadow=0.0;

  @override
  void initState() {
    super.initState();

    _animationController=AnimationController(vsync: this,duration: Duration(seconds: 2),);
    if(widget.logoAnimationFinished==true){
      _animationController.forward();
      _animationController.addListener(() {

        Timer(Duration(seconds: 2), (){
          setState(() {
            topAnimatedShadow=_animationController.value*7;
            lowerAnimatedShadow=_animationController.value*11;
          });
        });
      });
    }

  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.animatedSize,
      width: widget.animatedSize,
      child: Image.asset('images/sambleLogo.png'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        boxShadow: lowerAnimatedShadow==0?null:
        [
          BoxShadow(
            color: Color(0xff02e0b1),
            offset: Offset(-topAnimatedShadow, -topAnimatedShadow),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Color(0xff02a683),
            offset: Offset(lowerAnimatedShadow, lowerAnimatedShadow),
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
    );
  }
}
