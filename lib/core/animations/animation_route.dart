import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';

class AnimatedRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  final Object? arguments;
  final bool isFadeRoute;

  AnimatedRoute({
    required this.builder,
    this.arguments,
    this.isFadeRoute = true,
  }) : super(
         pageBuilder: (context, animation, _) => builder(context),
         settings: RouteSettings(arguments: arguments),
         transitionsBuilder: (context, animation, _, child) {
           if (isFadeRoute) {
             final position =
                 Tween<Offset>(
                   begin: const Offset(0, 1),
                   end: Offset.zero,
                 ).animate(
                   CurvedAnimation(parent: animation, curve: Curves.easeIn),
                 );
             return SlideTransition(position: position, child: child);
           } else {
             final scale = Tween<double>(begin: 0.0, end: 1.0).animate(
               CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
             );
             return ScaleTransition(scale: scale, child: child);
           }
         },
         transitionDuration: AppDurations.milliseconds_400,
         reverseTransitionDuration: AppDurations.milliseconds_400,
       );
}
