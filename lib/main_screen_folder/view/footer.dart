import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xfff4623a).withOpacity(0.01),
            Color(0xfff4623a).withOpacity(0.01),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Column(
          children: [
            Text(
              "Developed by Syed Ibrahim",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 4.sp,
                fontFamily: "Source",
              ),
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copyright_rounded,
                  color: Colors.white60,
                  size: 4.sp,
                ),
                Text(
                  "All Right Reserved",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 4.sp,
                    fontFamily: "Source",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
