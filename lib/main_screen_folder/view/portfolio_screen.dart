import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';

class PortfolioScreen extends StatelessWidget {
  PortfolioScreen({super.key});

  final MainController ctrl = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Responsive Grid Configuration
    int crossAxisCount;
    double horizontalPadding;
    double spacing;
    double aspectRatio;

    if (width < 600) {
      crossAxisCount = 1;
      horizontalPadding = 16;
      spacing = 20;
      aspectRatio = 1.0;
    } else if (width < 1276) {
      crossAxisCount = 1;
      horizontalPadding = width * 0.1;
      spacing = 40;
      aspectRatio = 1.2;
    } else if (width < 1684) {
      crossAxisCount = 2;
      horizontalPadding = 50;
      spacing = 40;
      aspectRatio = 1.5;
    } else {
      crossAxisCount = 3;
      horizontalPadding = 80;
      spacing = 50;
      aspectRatio = 1.2;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Portfolio",
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: ctrl.projectList.length,
                itemBuilder: (context, index) {
                  return GetBuilder<MainController>(
                    builder: (controller) {
                      return MouseRegion(
                        onEnter: (_) => ctrl.zoomIn(index),
                        onExit: (_) {
                          ctrl.zoomOut(index);
                          ctrl.toggleAnimation(index, forward: false);
                        },
                        child: AnimatedBuilder(
                          animation: ctrl.zoomAnimations[index],
                          builder: (context, child) {
                            return Transform.scale(
                              scale: ctrl.zoomAnimations[index].value,
                              child: AnimatedBuilder(
                                animation: ctrl.animations[index],
                                builder: (context, child) {
                                  return InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () => ctrl.toggleAnimation1(index),
                                    child: Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.0015)
                                        ..rotateY(
                                          pi * ctrl.animations[index].value,
                                        ),
                                      child: ctrl.animations[index].value <= 0.5
                                          ? _buildProjectFront(
                                              context,
                                              index,
                                              ctrl,
                                            )
                                          : _buildProjectBack(
                                              context,
                                              index,
                                              ctrl,
                                            ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProjectFront(
    BuildContext context,
    int index,
    MainController ctrl,
  ) {
    final project = ctrl.projectList[index];
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    double heading = isMobile ? 18 : 20;
    double description = isMobile ? 12 : 14;

    return Container(
      decoration: BoxDecoration(
        color: ctrl.toggle.value ? Colors.white : const Color(0xff111827),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
              ),
              child: Image.asset(
                project.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3.sp),
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  project.heading,
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Source",
                    fontSize: heading,
                    fontWeight: FontWeight.w700,
                    color: ctrl.toggle.value ? Colors.black : Colors.white,
                  ),
                ),
                Gap(10.h),
                Text(
                  project.description,
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Source",
                    fontSize: description,
                    color: ctrl.toggle.value
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Image takes remaining space
        ],
      ),
    );
  }

  Widget _buildProjectBack(
    BuildContext context,
    int index,
    MainController ctrl,
  ) {
    final project = ctrl.projectList[index];
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Container(
        decoration: BoxDecoration(
          color: ctrl.toggle.value
              ? const Color(0xfff9fafb)
              : const Color(0xff1f2937),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 14 : 20),
          child: Column(
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text(
                project.heading,
                style: TextStyle(
                  fontFamily: "Source",
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: ctrl.toggle.value ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    project.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "Source",

                      fontSize: isMobile ? 13 : 14,
                      color: ctrl.toggle.value
                          ? Colors.black87
                          : Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
