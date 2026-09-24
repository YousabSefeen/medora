import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/mappers/specialty_mapper.dart';

// Handles deep links navigation for specialty links (e.g., specialty://12).
abstract class SpecialtyLinkHandler {
  static const String _scheme = 'specialty://';

  static void handleNavigation(BuildContext context, String? href) {
    if (href == null || !href.startsWith(_scheme)) {
      log('Invalid specialty link: $href');
      return;
    }

    final idString = href.replaceFirst(_scheme, '');
    final specialtyId = int.tryParse(idString);

    if (specialtyId != null && specialtyId > 0) {
      final specialtyName = SpecialtyMapper.getEnglishName(specialtyId);
      context.push(AppRouterNames.specialtyDoctors, extra: specialtyName);
    }
  }
}
