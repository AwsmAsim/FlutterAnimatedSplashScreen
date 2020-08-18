import 'package:flutter/material.dart';
import 'app_colors.dart';

class LoadingBar extends StatefulWidget {

  final bool startAnimation;

  const LoadingBar({this.startAnimation=false});

  @override
  _LoadingBarState createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar> with TickerProviderStateMixin {
  AnimationController _loadingAnimationController;
  double loadingSize;

  @override
  void initState() {
    super.initState();

    _loadingAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1,milliseconds: 500));
    if(widget.startAnimation==true){
      _loadingAnimationController.forward();
      _loadingAnimationController..addListener(() {
        setState(() {
          loadingSize = _loadingAnimationController.value*MediaQuery.of(context).size.width;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: loadingSize,
          height: 10.0,
          decoration: BoxDecoration(
            color: textColor,
          ),
        ),
      ),
    );
  }
}