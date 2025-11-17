import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';
import 'package:my_portfolio/main_screen_folder/view/Skills.dart';
import 'package:my_portfolio/main_screen_folder/view/Widgets/portfolio_app_bar.dart';
import 'package:my_portfolio/main_screen_folder/view/contact.dart';
import 'package:my_portfolio/main_screen_folder/view/footer.dart';
import 'package:my_portfolio/main_screen_folder/view/home.dart';
import 'package:my_portfolio/main_screen_folder/view/portfolio_screen.dart';
import 'package:my_portfolio/main_screen_folder/view/services.dart';

class MainScreenFile extends StatelessWidget {
  MainScreenFile({super.key});

  final ctrl = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: PortfolioAppBar(),
      // MOBILE DRAWER
      drawer: Drawer(
        backgroundColor: Color(0xff253745),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                drawerItem("Home", ctrl.homeKey, context),
                drawerItem("Services", ctrl.serviceKey, context),
                drawerItem("Portfolio", ctrl.portfolioKey, context),
                drawerItem("Skills", ctrl.skillsKey, context),
                drawerItem("Contact", ctrl.contactKey, context),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ctrl.scrollController,
        child: Column(
          children: [
            // HOME SECTION
            SectionContainer(
              key: ctrl.homeKey,
              gradient: LinearGradient(
                colors: [
                  Color(0xfff4623a).withOpacity(0.1),
                  Color(0xff0060bb).withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: Stack(
                children: [
                  // 🔥 Background HELLO text
                  Positioned(
                    child: Center(
                      child: Text(
                        "hello",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: "Source",
                          fontSize: 130,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(
                            0.05,
                          ), // faded background effect
                          letterSpacing: 10,
                        ),
                      ),
                    ),
                  ),

                  // 🔥 Your actual home content on top
                  Padding(padding: const EdgeInsets.all(20.0), child: Home()),
                ],
              ),
            ),

            // SERVICES SECTION
            SectionContainer(
              key: ctrl.serviceKey,
              gradient: LinearGradient(
                colors: [
                  Color(0xff1B2730).withOpacity(0.5),
                  Color(0xff11212D).withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: ServicesPage(),
            ),

            // SKILLS SECTION
            SectionContainer(
              key: ctrl.portfolioKey,
              gradient: LinearGradient(
                colors: [
                  Color(0xff1B2730).withOpacity(0.1),
                  Color(0xff1B2730).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: PortfolioScreen(),
            ),
            SectionContainer(
              key: ctrl.skillsKey,
              gradient: LinearGradient(
                colors: [
                  Color(0xfff4623a).withOpacity(0.1),
                  Color(0xff0060bb).withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: Skills(),
            ),

            // CONTACT SECTION
            SectionContainer(
              key: ctrl.contactKey,
              gradient: LinearGradient(
                colors: [
                  Color(0xff141E30).withOpacity(0.2),
                  Color(0xff243B55).withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: Contact(),
            ),
            Footer(),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => ctrl.showFab.value
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(shape: CircleBorder()),
                onPressed: () => ctrl.scrollToTop(),
                child: Icon(
                  Icons.keyboard_arrow_up_outlined,
                  color: Color(0xfff4623a),
                  size: 35,
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}

class SectionContainer extends StatelessWidget {
  final Widget child;
  final Gradient gradient;

  const SectionContainer({
    super.key,
    required this.child,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 120),
      child: child,
      decoration: BoxDecoration(gradient: gradient),
    );
  }
}

Widget drawerItem(String label, GlobalKey key, BuildContext context) {
  final ctrl = Get.find<MainController>();

  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
      ctrl.scrollTo(key, label);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: "Source",
          fontSize: 18,
          color: ctrl.activeTab.value == label
              ? Color(0xfff4623a)
              : Colors.white,
          fontWeight: ctrl.activeTab.value == label
              ? FontWeight.bold
              : FontWeight.w400,
        ),
      ),
    ),
  );
}
