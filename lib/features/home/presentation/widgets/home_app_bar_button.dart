import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon;
import 'package:medora/features/home/presentation/constants/home_constants.dart'
    show HomeConstants;

class HomeAppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HomeAppBarButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.black,
      splashRadius: 30,
      style: _createButtonStyle(),
      onPressed: onPressed,
      icon: FaIcon(icon, size: HomeConstants.iconSize),
    );
  }

  ButtonStyle _createButtonStyle() => const ButtonStyle(
    backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
    elevation: WidgetStatePropertyAll<double>(3),
    overlayColor: WidgetStatePropertyAll<Color>(Colors.black),
  );
}
