import 'package:flutter/material.dart';

class CustomAnimationRoute extends PageRouteBuilder {
  final Widget screen;
  final Object? arguments;

  final bool isAddTaskScreen;

  CustomAnimationRoute({
    this.isAddTaskScreen = false,
    required this.screen,
    this.arguments,
  }) : super(
         pageBuilder: (BuildContext context, animation, _) => screen,
         settings: RouteSettings(arguments: arguments),
         transitionsBuilder: (context, animation, _, child) {
           if (isAddTaskScreen) {
             final position =
                 Tween<Offset>(
                   begin: const Offset(0, 1),
                   end: const Offset(0, 0),
                 ).animate(
                   CurvedAnimation(parent: animation, curve: Curves.easeIn),
                 );
             return SlideTransition(position: position, child: screen);
           } else {
             final scale = Tween<double>(begin: 0.0, end: 1.0).animate(
               CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
             );

             return ScaleTransition(scale: scale, child: screen);
           }
         },
         transitionDuration: Duration(milliseconds: 500),
         reverseTransitionDuration: Duration(milliseconds: 500),
       );
}
