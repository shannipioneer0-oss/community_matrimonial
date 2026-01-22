

import 'package:flutter/cupertino.dart';

class Animations{

  PageRouteBuilder setAnimation(Widget widget){

  return  PageRouteBuilder(
      pageBuilder: (context , animation , secondaryAnimation) => widget,
      transitionsBuilder: (context , animation , secondaryAnimation , child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offsetAnimation,
            child: widget,
          ),
        );
      },
    );

  }



  PageRouteBuilder setFadeAnimation(Widget widget){

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offsetAnimation,
            child: widget,
          ),
        );
      },
    );

  }





  PageRouteBuilder rotation(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOutCubic));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: RotationTransition(
              turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                child: widget,
              ),
            ),
          ),
        );
      },
    );
  }


  PageRouteBuilder customPageRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var offsetTween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOutCubic));
        var offsetAnimation = animation.drive(offsetTween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: widget,
          ),
        );
      },
    );
  }


}