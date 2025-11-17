import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';

class Skills extends StatelessWidget {
  Skills({super.key});

  final MainController ctrl = Get.put(MainController());

  final List<Map<String, String>> skills = [
    {"img": "assets/images/dart_logo.png", "name": "Dart"},
    {"img": "assets/images/flutter_logo.png", "name": "Flutter"},
    {"img": "assets/images/getx_logo.png", "name": "GetX"},
    // {"img": "assets/images/bloc_logo.png", "name": "Bloc"},
    {"img": "assets/images/firebase_logo.png", "name": "Firebase"},
    {"img": "assets/images/rest_api.png", "name": "RestApi"},
    {"img": "assets/images/gitlab_logo.png", "name": "GitLab"},
    {"img": "assets/images/git_logo.png", "name": "Git"},
    {"img": "assets/images/github_logo.png", "name": "GitHub"},
    {"img": "assets/images/figma_logo.png", "name": "Figma"},
    // {"img": "assets/images/android_logo.png", "name": "Android"},
    // {"img": "assets/images/ios_logo.png", "name": "iOS"},
    {"img": "assets/images/node_logo.png", "name": "Node.js"},
    {"img": "assets/images/postgre_logo.png", "name": "PostgreSQL"},
  ];

  @override
  Widget build(BuildContext context) {
    ctrl.initSkillsHover(skills.length); // 🔥 initialize hover list

    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth ~/ 150).clamp(2, 5);
    double spacing = 9.w;
    double imageHeight = .06.sh;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Skills",
          style: TextStyle(
            fontFamily: "Source",
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Gap(20.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: .1.sw),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: 1,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return Obx(
                () => MouseRegion(
                  onEnter: (_) => ctrl.onSkillHover(index, true),
                  onExit: (_) => ctrl.onSkillHover(index, false),
                  child: Transform.scale(
                    scale: ctrl.skillsHover[index] ? 1.08 : 1.0,
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                      elevation: 6,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 230),
                        decoration: BoxDecoration(
                          gradient: ctrl.skillsHover[index]
                              ? LinearGradient(
                                  colors: [
                                    const Color(0xfff4623a),
                                    const Color(0xfff4623a).withOpacity(0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    Color(0xff1B2730),
                                    Color(0xff11212D),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                          border: Border.all(
                            color: ctrl.skillsHover[index]
                                ? Colors.transparent
                                : Colors.white60,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            if (ctrl.skillsHover[index])
                              BoxShadow(
                                color: const Color(0xfff4623a).withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 6),
                              ),
                          ],
                        ),

                        child: Padding(
                          padding: EdgeInsets.all(6.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: imageHeight,
                                child: Image.asset(
                                  skills[index]["img"]!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                skills[index]["name"]!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
