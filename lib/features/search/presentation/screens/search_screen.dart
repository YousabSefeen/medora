import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/common_widgets/sliver_loading%20_list.dart' show SliverLoadingList;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_list/presentation/widgets/doctor_list_view.dart' show DoctorListView;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart' show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart' show SearchStates;
import 'package:medora/features/search/presentation/widgets/search_welcome_widget.dart' show SearchWelcomeWidget;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Text(
                'Let\'s Find Your\nDoctor',
                style: GoogleFonts.lato(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.black,
                  height: 1.2,
                  letterSpacing: 1,wordSpacing: 5
                ),
                textAlign: TextAlign.start,
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextFormField(
                      style: textTheme.styleInputField,
                      onChanged: (value) {
                        context
                            .read<SearchCubit>()
                            .onSearchQueryChanged( value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: Colors.grey.shade600,
                            size: 15.sp,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        hintText: 'Find the right doctor for you',
                        hintStyle: textTheme.hintFieldStyle,
                        fillColor: AppColors.fieldFillColor,
                        filled: true,
                        border: _buildBorder(AppColors.fieldBorderColor),
                        enabledBorder: _buildBorder(AppColors.fieldBorderColor),
                        focusedBorder: _buildBorder(Colors.black26),
                        errorBorder: _buildBorder(Colors.red),
                        errorStyle: textTheme.styleInputFieldError,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                          WidgetStateProperty.all(AppColors.fieldFillColor),
                      

                      elevation: WidgetStateProperty.all(1),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                            color: AppColors.fieldBorderColor,
                          ))),
                    ),
                    onPressed: () {},
                    child: FaIcon(
                      FontAwesomeIcons.sliders,
                      color: Colors.black54,
                      size: 18.sp,
                    ),
                  )
                ],
              ),

            ],
          ),
        ),

        BlocBuilder<SearchCubit, SearchStates>(
          builder: (context, state) {


            switch (state.searchResultsState) {


              case LazyRequestState.lazy:
              return const SearchWelcomeWidget();
              case LazyRequestState.loading:
                return const SliverLoadingList(height: 150);
              case LazyRequestState.loaded:
              return    DoctorListView(doctorList: state.searchResults);
              case LazyRequestState.error:
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                    '  state.doctorListError',
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  ),
                );
            }
            // // عرض مؤشر التحميل
            // if (state.searchResultsState == RequestState.loading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            //
            // // عرض رسالة ترحيبية عند عدم وجود نتائج
            //
            //
            // // عرض رسالة "لا توجد نتائج"
            // if (state.searchResults.isEmpty  ) {
            //   return const Center(
            //     child: Text(
            //       'No results found. Try a different search.',
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Colors.grey,
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   );
            // }

            // عرض قائمة النتائج
            return      const SearchWelcomeWidget();
            return DoctorListView(doctorList: state.searchResults);
          },
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.r),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
