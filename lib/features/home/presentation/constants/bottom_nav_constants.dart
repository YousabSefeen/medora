import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/features/appointments/presentation/screens/booked_appointments_screen.dart';
import 'package:medora/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:medora/features/home/presentation/screens/home_screen.dart';
import 'package:medora/features/settings/presentation/screens/settings_screen.dart';

class BottomNavConstants {
  BottomNavConstants._();

  static const searchTabIndex = 4;
  static const iconList = <FaIconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.calendarDays,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.gear,
  ];
  static const appBarTitles = <String>[
    AppStrings.dummyTitle,
    AppStrings.myAppointments,
    AppStrings.myFavoriteDoctors,
    AppStrings.setting,
    AppStrings.search,
  ];

  static const titles = <String>[
    AppStrings.home,
    AppStrings.appointments,
    AppStrings.favorite,
    AppStrings.setting,
  ];

  static const List<Widget> screens = [
    HomeScreen(),
    BookedAppointmentsScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
}
