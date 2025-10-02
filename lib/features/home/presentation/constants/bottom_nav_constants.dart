



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show IconData, Widget, Center, Text;

import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FontAwesomeIcons;
import 'package:medora/features/appointments/presentation/screens/booked_appointments_screen.dart' show BookedAppointmentsScreen;
import 'package:medora/features/home/presentation/screens/home_screen.dart' show HomeScreen;
import 'package:medora/features/settings/presentation/screens/settings_screen.dart' show SettingsScreen;

class BottomNavConstants{
  static const searchTabIndex = 4;
 static   const iconList = <IconData>[
    FontAwesomeIcons.houseChimneyMedical,
    FontAwesomeIcons.calendarDays,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.gear,
  ];
  static const appBarTitles = <String>[
    'Dummy Title ',
    'My Appointments',
    'My Favorite Doctors',
    'Setting',
    'Search',
  ];

  static const titles = <String>[
    'Home',
    'Appointments',
    'Favorite',
    'Setting',
  ];

// يجب أن تكون الشاشات في مكان منفصل ومنظم
  static const  List<Widget> screens = [

    HomeScreen(),

    BookedAppointmentsScreen(),
      Center(child: Text('Screen Three')),
    SettingsScreen(),
  ];


}