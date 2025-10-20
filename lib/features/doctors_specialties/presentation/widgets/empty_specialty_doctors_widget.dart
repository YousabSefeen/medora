import 'package:flutter/material.dart';
import 'package:medora/generated/assets.dart' show Assets;

class EmptySpecialtyDoctorsWidget extends StatelessWidget {
  final String specialtyName;

  const EmptySpecialtyDoctorsWidget({super.key, required this.specialtyName});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesStethoscope,
              height: MediaQuery.sizeOf(context).height * 0.35,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'No $specialtyName Doctors Yet',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'We are working to add specialists\nin this field soon.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
