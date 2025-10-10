import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

class SpecialtiesFilterGrid extends StatefulWidget {
  const SpecialtiesFilterGrid({super.key});

  @override
  State<SpecialtiesFilterGrid> createState() => _SpecialtiesFilterGridState();
}

class _SpecialtiesFilterGridState extends State<SpecialtiesFilterGrid> {
  late ScrollController gridScrollController;

  @override
  void initState() {
    gridScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    gridScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: ScrollbarTheme(
        data: Theme.of(context).scrollbarTheme.copyWith(
          crossAxisMargin: 0,
          trackBorderColor: WidgetStateProperty.all(AppColors.fieldBorderColor ),
          trackColor: WidgetStateProperty.all(AppColors.fieldBorderColor ),
          thumbColor: WidgetStateProperty.all(Colors.blue),
        ),
        child: Scrollbar(
          controller: gridScrollController,
          thumbVisibility: true,
          child: GridView.builder(
            controller: gridScrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(bottom: 20),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 5,
            ),
            itemCount: AppStrings.allMedicalSpecialties.length,
            itemBuilder: (context, index) => _buildSpecialtyItem(
              context,
              AppStrings.allMedicalSpecialties[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialtyItem(BuildContext context, String specialty) {
    return Container(
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.grey, width: 0.5),
        ),
      ),
      child: Text(
        specialty,
        style: Theme.of(context).textTheme.mediumBlack.copyWith(
          color: Colors.black,
          height: 1.2,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
