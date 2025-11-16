import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

  final MainController ctrl = Get.put(MainController());

  final List<Map<String, String>> services = [
    {
      "title": "Mobile App Development",
      "desc":
          "I build high-performance, responsive, and scalable mobile applications using Flutter. From UI design to backend integration, I ensure seamless user experience across Android & iOS.",
    },
    {
      "title": "UI/UX Design Implementation",
      "desc":
          "I transform UI/UX designs into pixel-perfect Flutter interfaces. Clean layouts, smooth animations, and modern design patterns for a premium user experience.",
    },
    {
      "title": "API Integration & Backend Connectivity",
      "desc":
          "Secure and optimized integration of REST APIs, Firebase, and third-party services. Reliable data flow and real-time updates for dynamic applications.",
    },
    {
      "title": "State Management Solutions",
      "desc":
          "Efficient app architecture using GetX or Bloc. Improved performance, maintainability, and clean code structure.",
    },
    {
      "title": "Firebase Services",
      "desc":
          "Seamless Firebase setup including authentication, Firestore DB, cloud storage, push notifications, and crash monitoring.",
    },
    {
      "title": "App Deployment (Play Store / App Store)",
      "desc":
          "Complete publishing support: app signing, bundle creation, metadata, screenshots, and store upload.",
    },
  ];

  final primaryColor = Color(0xfff4623a);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "My Services",
          style: TextStyle(
            fontFamily: "Source",
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(30.h),

        // --- LISTVIEW 2 PER ROW ---
        Padding(
          padding: EdgeInsets.symmetric(horizontal: .1.sw),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (services.length / 2).ceil(),
            itemBuilder: (_, rowIndex) {
              final int i1 = rowIndex * 2;
              final int i2 = i1 + 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _serviceCard(i1)),
                    Gap(6.w),
                    Expanded(
                      child: i2 < services.length
                          ? _serviceCard(i2)
                          : SizedBox(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _serviceCard(int index) {
    final service = services[index];

    return Obx(
      () => MouseRegion(
        onEnter: (_) => ctrl.onHover(index, true),
        onExit: (_) => ctrl.onHover(index, false),
        child: Transform.scale(
          scale: ctrl.isHovered[index] ? 1.03 : 1.0,
          child: Material(
            color: Colors.transparent,
            elevation: 6,
            borderRadius: BorderRadius.circular(18.r),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              margin: EdgeInsets.only(bottom: 25.h),
              decoration: BoxDecoration(
                gradient: ctrl.isHovered[index]
                    ? LinearGradient(
                        colors: [primaryColor, primaryColor.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [Color(0xff1B2730), Color(0xff11212D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                border: ctrl.isHovered[index]
                    ? null
                    : Border.all(color: Colors.white24, width: 1.1),
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  if (ctrl.isHovered[index])
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 25,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                ],
              ),

              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      service["title"]!,
                      style: TextStyle(
                        fontFamily: "Source",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    Gap(8.h),

                    // Description
                    Text(
                      service["desc"]!,
                      style: TextStyle(
                        fontFamily: "Source",
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
