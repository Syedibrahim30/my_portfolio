import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';
import 'package:my_portfolio/main_screen_folder/view/Widgets/hover_container.dart';

class Contact extends StatelessWidget {
  Contact({super.key});

  final MainController ctrl = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            textAlign: TextAlign.center,
            "Contact",
            style: TextStyle(
              fontFamily: "Source",
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: .1.sw),
          child: Text(
            "LET'S WORK TOGETHER",
            style: TextStyle(
              fontFamily: "Source",
              fontSize: 25.sp,
              color: Color(0xfff4623a),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: .1.sw),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10.w,
            spacing: 10.w,
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
                child: HoverContainer(
                  height: 80,
                  weight: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.white, size: 24),
                      Gap(6.h),
                      Text(
                        "syedibrahim4076@gmail.com",
                        style: TextStyle(
                          fontFamily: "Source",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () =>
                    ctrl.myLaunchUrl('https://www.linkedin.com/in/syed30/'),
                child: HoverContainer(
                  height: 80,
                  weight: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/linkedin.png",
                        height: 24,
                        fit: BoxFit.fill,
                        color: Colors.white,
                      ),
                      Gap(6.h),
                      Text(
                        "www.linkedin.com/in/syed30",
                        style: TextStyle(
                          fontFamily: "Source",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    ctrl.myLaunchUrl('hhttps://github.com/Syedibrahim30'),

                child: HoverContainer(
                  height: 80,
                  weight: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/github_logo.png",
                        height: 24,
                        fit: BoxFit.fill,
                        color: Colors.white,
                      ),
                      Gap(6.h),
                      Text(
                        "Syedibrahim30",
                        style: TextStyle(
                          fontFamily: "Source",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => ctrl.myLaunchUrl(
                  'https://wa.me/918838864641?text=Hi%20Mohammed!',
                ),
                child: HoverContainer(
                  height: 80,
                  weight: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/whatsapp.png",
                        height: 24,
                        fit: BoxFit.fill,
                        color: Colors.white,
                      ),
                      Gap(6.h),
                      Text(
                        "+91 8838864641",
                        style: TextStyle(
                          fontFamily: "Source",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
