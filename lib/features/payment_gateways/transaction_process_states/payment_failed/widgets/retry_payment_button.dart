import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;

class RetryPaymentButton extends StatelessWidget {
  const RetryPaymentButton({super.key});

  final String retryPayment = 'Retry Payment';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => AppRouter.redirectToPaymentGateways(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        retryPayment,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
