import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';

class PortfolioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MainController ctrl = Get.find();

  final Color fontColor = const Color(0xffCCD0CF);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return AppBar(
      automaticallyImplyLeading: false, // <— ADD THIS

      backgroundColor: isMobile
          ? Color(0xfff4623a).withOpacity(0.5)
          : Color(0xff121212),
      centerTitle: true,
      elevation: 0,

      // MOBILE → Show hamburger icon
      leading: isMobile
          ? Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,

      title: !isMobile
          ? Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  menuItem("Home", ctrl.homeKey),
                  menuItem("Services", ctrl.serviceKey),
                  menuItem("Portfolio", ctrl.portfolioKey),
                  menuItem("Skills", ctrl.skillsKey),
                  menuItem("Contact", ctrl.contactKey),
                ],
              ),
            )
          : Text(
              "Portfolio",
              style: TextStyle(
                fontFamily: "Source",

                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  // Drawer items & AppBar items use same menu widget
  Widget menuItem(String label, GlobalKey key) {
    return GestureDetector(
      onTap: () {
        ctrl.scrollTo(key, label);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 6.sp,
            fontFamily: "Source",
            color: ctrl.activeTab.value == label
                ? Color(0xfff4623a)
                : fontColor.withOpacity(0.8),
            fontWeight: ctrl.activeTab.value == label
                ? FontWeight.bold
                : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
