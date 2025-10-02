import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryCodeWithFlag extends StatelessWidget {
  const CountryCodeWithFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
      ),
      child: Text(
        _generateCountryFlag() + ' +20',
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
        );
    return flag;
  }
}
