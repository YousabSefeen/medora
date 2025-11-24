import 'package:flutter/material.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;
import 'package:medora/features/shared/widgets/doctor_card.dart'
    show DoctorCard;


class DoctorListView extends StatelessWidget {
  final List<DoctorModel> doctorList;

  const DoctorListView({super.key, required this.doctorList});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      sliver: SliverList.builder(
        itemCount: doctorList.length,
        itemBuilder: (context, index) => DoctorCard(doctor: doctorList[index]),
      ),
    );
  }
}
