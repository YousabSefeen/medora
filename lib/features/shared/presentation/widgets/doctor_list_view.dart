import 'package:flutter/material.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';
import 'package:medora/features/shared/presentation/widgets/doctor_card.dart'
    show DoctorCard;

class DoctorListView extends StatelessWidget {
  final List<DoctorEntity> doctorList;

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
