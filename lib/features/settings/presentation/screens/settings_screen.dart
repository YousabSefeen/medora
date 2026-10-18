/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/home/presentation/widgets/home_screen_padding.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreenPadding(
      child: Column(
        spacing: 20,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: AppColors.softBlue,
            child: Center(
              child: Text(
                'MediLink',
                style: GoogleFonts.poppins(
                  fontSize: 36.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.manage_accounts,
              size: 16.sp,
              color: Colors.black,
            ),
            title: FittedBox(
              child: Text(
                'Doctor Panel',
                style: TextStyle(fontSize: 15.sp, color: Colors.black),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
              color: Colors.black54,
            ),
            onTap: () => context.push(AppRouterNames.doctorProfile),
          ),
          ListTile(
            leading: Icon(
              Icons.manage_accounts,
              size: 16.sp,
              color: Colors.black,
            ),
            title: FittedBox(
              child: Text(
                'My Appointment',
                style: TextStyle(fontSize: 15.sp, color: Colors.black),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
              color: Colors.black54,
            ),
            onTap: () => context.push(AppRouterNames.bookedAppointments),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<AuthCubit>().signOut();
                context.go(AppRouterNames.signIn);
              },
              label: const Text(AppStrings.signOut),
              icon: const Icon(
                Icons.login_rounded,
                color: Colors.black,
                size: 20,
              ),
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';

import '../widgets/logout_button.dart';
import '../widgets/user_profile_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      children: [
        Text(
          AppStrings.settings,
          style: context.textTheme.appBarTitleStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        // 1. User Profile Header Card
        const UserProfileCard(),
        const SizedBox(height: 24),

        // 2. Account Settings Section
        _buildSectionHeader(context, AppStrings.accountSettings),
        const SizedBox(height: 8),
        _SettingsCard(
          children: [
            _SettingsTile(
              icon: Icons.person_outline_rounded,
              title: AppStrings.personalInformation,
              // الانتقال لتعديل الملف الشخصي
              onTap: () => context.push(AppRouterNames.editProfile),
            ),
            _buildDivider(),
            _SettingsTile(
              icon: Icons.language_rounded,
              title: AppStrings.appLanguage,
              trailing: const _BadgeText(text: 'العربية'),
              onTap: () {
                // فتح نافذة اختيار اللغة
                _showLanguageBottomSheet(context);
              },
            ),
            _buildDivider(),
            _SettingsTile(
              icon: Icons.notifications_outlined,
              title: AppStrings.notificationPreferences,
              onTap: () {
                // الانتقال لإعدادات الإشعارات
              },
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 3. Legal & Google Play Compliance Section
        _buildSectionHeader(context, AppStrings.legalAndPrivacy),
        const SizedBox(height: 8),
        _SettingsCard(
          children: [
            _SettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: AppStrings.privacyPolicy,
              onTap: () {
                // فتح سياسة الخصوصية (WebView أو رابط خارجي)
              },
            ),
            _buildDivider(),
            _SettingsTile(
              icon: Icons.description_outlined,
              title: AppStrings.termsAndConditions,
              onTap: () {
                // فتح شروط الاستخدام
              },
            ),
            _buildDivider(),
            _SettingsTile(
              icon: Icons.health_and_safety_outlined,
              title: AppStrings.medicalDisclaimer,

              // عرض رسالة إخلاء المسؤولية الطبية والذكاء الاصطناعي
              onTap: () => context.push(AppRouterNames.medicalDisclaimer),
            ),
            _buildDivider(),
            _SettingsTile(
              icon: Icons.delete_outline_rounded,
              title: AppStrings.deleteAccount,
              iconColor: AppColors.brightRed,
              titleColor: AppColors.brightRed,
              onTap: () {
                // إظهار حوار تأكيد حذف الحساب (متوافق مع سياسة Google Play)
              },
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 4. Support & About Section
        _buildSectionHeader(context, AppStrings.supportAndAbout),
        const SizedBox(height: 8),
        _SettingsCard(
          children: [
            _SettingsTile(
              icon: Icons.help_outline_rounded,
              title: AppStrings.helpAndSupport,
              onTap: () {
                // التواصل والدعم الفني
              },
            ),
            _buildDivider(),
            _SettingsTile(
              icon: Icons.star_outline_rounded,
              title: AppStrings.rateApp,
              onTap: () {
                // فتح متجر جوجل بلاي للتقييم
              },
            ),
            _buildDivider(),
            _SettingsTile(
              icon: Icons.info_outline_rounded,
              title: AppStrings.aboutApp,
              trailing: const _BadgeText(text: 'v1.0.0'),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),

        // 5. Logout Action Button
        const LogoutButton(),
        const SizedBox(height: 30),
      ],
    );
  }

  void _showLanguageBottomSheet(BuildContext context) =>
      AppAlerts.showCustomBottomSheet(
        context: context,
        appBarBackgroundColor: AppColors.softBlue,
        appBarTitle: AppStrings.appLanguage,
        appBarTitleColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              ListTile(
                leading: const Text(
                  '🇪🇬',
                  style: TextStyle(fontSize: 22, color: AppColors.midnightBlue),
                ),
                title: const Text(
                  'العربية',
                  style: TextStyle(color: AppColors.midnightBlue),
                ),
                trailing: Localizations.localeOf(context).languageCode == 'ar'
                    ? Icon(Icons.check_circle, color: AppColors.greenLight)
                    : null,
                onTap: () {
                  // context.read<LocaleCubit>().changeLanguage('ar');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Text(
                  '🇺🇸',
                  style: TextStyle(fontSize: 22, color: AppColors.midnightBlue),
                ),
                title: const Text(
                  'English',
                  style: TextStyle(color: AppColors.midnightBlue),
                ),
                trailing: Localizations.localeOf(context).languageCode == 'en'
                    ? Icon(Icons.check_circle, color: AppColors.greenLight)
                    : null,
                onTap: () {
                  // context.read<LocaleCubit>().changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade100,
      indent: 54, // لترك مسافة تحت الأيقونة بشكل جمالي
    );
  }
}

// =============================================================================
// REUSABLE UI COMPONENTS (Clean Code & Modern Design)
// =============================================================================

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,

        // لضمان انضباط الحواف المستديرة مع تأثير الضغط
        child: Column(children: children),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    /*
    Material(
      color: Colors.white,elevation: 0.5,
      borderRadius: BorderRadius.circular(8),
     */
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.softBlue).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor ?? AppColors.softBlue, size: 22.r),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.black87,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) ...[trailing!, const SizedBox(width: 8)],
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.r,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class _BadgeText extends StatelessWidget {
  final String text;

  const _BadgeText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
