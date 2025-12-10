import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;

class UseADifferentCardButton extends StatelessWidget {
  const UseADifferentCardButton({super.key});

  final String useADifferentCard = 'Use a Different Card';

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => AppRouter.redirectToPaymentGateways(context),
      child: Text(
        useADifferentCard,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
