import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';
import 'package:my_portfolio/main_screen_folder/view/Widgets/hover_container.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final MainController ctrl = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xff06141B);
    final fontColor = Color(0xfff4623a);
    final secondaryFontColor = Color(0xff0060bb);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Hi, I’m",
          style: TextStyle(
            fontFamily: "Source",
            color: Colors.white60,
            fontSize: 30,
            letterSpacing: 1.2,
          ),
        ),
        Gap(10.h),
        Text(
          "Syed Ibrahim",
          style: TextStyle(
            fontFamily: "Source",
            color: Colors.white,
            fontSize: 40,
            letterSpacing: 1.2,
          ),
        ),
        Gap(10.h),
        Text(
          textAlign: TextAlign.center,
          "Flutter Developer | Mobile App Developer",
          style: TextStyle(
            fontFamily: "Source",
            color: fontColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.3,
          ),
        ),
        Gap(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: .1.sw),
          child: Text(
            textAlign: TextAlign.center,
            "A passionate Flutter Developer crafting smooth, modern, and high-performance mobile apps.I specialize in building scalable UI, clean architecture, and delivering seamless user experiences.",
            style: TextStyle(
              fontFamily: "Source",
              color: Colors.white60,
              fontSize: 20,
            ),
          ),
        ),
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'syedibrahim4076@gmail.com',
                  query:
                      'subject=Hello Syed Ibrahim&body=Hi, I’d like to connect!',
                );
                await ctrl.myLaunchUrl(emailUri.toString());
              },
              child: HoverCircleContainer(
                child: Center(
                  child: Icon(Icons.email, color: Colors.white, size: 22),
                ),
              ),
            ),
            Gap(6.w),
            GestureDetector(
              onTap: () =>
                  ctrl.myLaunchUrl('hhttps://github.com/Syedibrahim30'),

              child: HoverCircleContainer(
                child: Center(
                  child: Image.asset(
                    "assets/images/github.png",
                    height: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap(6.w),
            GestureDetector(
              onTap: () =>
                  ctrl.myLaunchUrl('https://www.linkedin.com/in/syed30/'),
              child: HoverCircleContainer(
                child: Center(
                  child: Image.asset(
                    "assets/images/linkedin.png",
                    height: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap(6.w),
            GestureDetector(
              onTap: () => ctrl.myLaunchUrl(
                'https://wa.me/918838864641?text=Hi%20Mohammed!',
              ),

              child: HoverCircleContainer(
                child: Center(
                  child: Image.asset(
                    "assets/images/whatsapp.png",
                    height: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                ctrl.scrollTo(ctrl.contactKey, "Contact");
              },
              child: HoverContainer(
                child: Center(
                  child: Text(
                    "Let's Connect",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Source",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Gap(6.w),
            InkWell(
              onTap: () {
                ctrl.downloadCV();
              },
              child: HoverWithoutColorContainer(
                child: Center(
                  child: Text(
                    "Download CV",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Source",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
