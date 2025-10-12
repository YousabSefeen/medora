import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/search/presentation/widgets/filters/specialities_filter/specialty_item.dart'
    show SpecialtyItem;

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
      height: 135,
      child: ScrollbarTheme(
        data: Theme.of(context).scrollbarTheme.copyWith(
          crossAxisMargin: 1,
          mainAxisMargin: 1,
          trackBorderColor: WidgetStateProperty.all(AppColors.white),
          //  trackColor: WidgetStateProperty.all(Color(0xff708993)),
          trackColor: WidgetStateProperty.all(Colors.black12),
          thumbColor: WidgetStateProperty.all(AppColors.white),
        ),
        child: Scrollbar(
          controller: gridScrollController,

          thumbVisibility: true,
          child: GridView.builder(
            controller: gridScrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(bottom: 20),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 5,
            ),
            itemCount: AppStrings.allMedicalSpecialties.length,
            itemBuilder: (context, index) => SpecialtyItem(
              key: ValueKey(AppStrings.allMedicalSpecialties[index]),
              specialty: AppStrings.allMedicalSpecialties[index],
            ),
          ),
        ),
      ),
    );
  }
}
