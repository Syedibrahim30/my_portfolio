import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'download_stub.dart' if (dart.library.html) 'download_web.dart';

class MainController extends GetxController with GetTickerProviderStateMixin {
  // ignore: avoid_web_libraries_in_flutter

  Future<void> downloadCV() async {
    try {
      final response = await http.get(Uri.parse('https://ipapi.co/json/'));

      String country = 'Unknown';
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        country = data['country_name'] ?? 'Unknown';
        print("Country=====$country");
      }

      String pdfPath = "assets/pdf/Syed_Ibrahim_Rezume.pdf";

      // Load bytes
      ByteData data = await rootBundle.load(pdfPath);
      Uint8List bytes = data.buffer.asUint8List();

      // Will call:
      // → download_web.dart on Web
      // → download_stub.dart on Android/iOS/Desktop
      downloadPDFWeb(bytes, pdfPath.split('/').last);
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  RxList<bool> skillsHover = <bool>[].obs;

  void initSkillsHover(int length) {
    skillsHover.value = List<bool>.filled(length, false);
  }

  void onSkillHover(int index, bool value) {
    skillsHover[index] = value;
  }

  RxList<bool> isHovered = List<bool>.filled(6, false).obs;

  void onHover(int index, bool value) {
    isHovered[index] = value;
    update();
  }

  /*
  Future<void> downloadCV() async {
    try {
      final response = await http.get(Uri.parse('https://ipapi.co/json/'));

      String country = 'Unknown';
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        country = data['country_name'] ?? 'Unknown';
        print("Country=====$country");
      }

      String pdfPath = "assets/pdf/Syed_Ibrahim_Rezume.pdf";

      // Load PDF bytes
      ByteData data = await rootBundle.load(pdfPath);
      Uint8List bytes = data.buffer.asUint8List();

      // Web download (Android/iOS/Desktop will be ignored safely)
      downloadPDFWeb(bytes, pdfPath.split('/').last);
    } catch (e) {
      print("Download error: $e");
    }
  }
*/

  final scrollController = ScrollController();

  // Each section key
  final homeKey = GlobalKey();
  final serviceKey = GlobalKey();
  final portfolioKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();

  // Active tab for color
  var activeTab = "Home".obs;

  // Scroll to a section
  void scrollTo(GlobalKey key, String tabName) {
    activeTab.value = tabName;

    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Detect which tab should highlight during scroll
  void onScroll() {
    _checkPosition(homeKey, "Home");
    _checkPosition(serviceKey, "Services");
    _checkPosition(portfolioKey, "Portfolio");
    _checkPosition(skillsKey, "Skills");
    _checkPosition(contactKey, "Contact");
  }

  void _checkPosition(GlobalKey key, String tabName) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      double position = box.localToGlobal(Offset.zero).dy;
      if (position <= 150 && position >= -150) {
        activeTab.value = tabName;
      }
    }
  }

  Future<void> myLaunchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  /// Flip animation controllers + animations
  late List<AnimationController> animationControllers;
  late List<Animation<double>> animations;

  /// Zoom animation controllers + animations (hover)
  late List<AnimationController> zoomControllers;
  late List<Animation<double>> zoomAnimations;
  RxBool showFab = false.obs;
  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onInit() {
    scrollController.addListener(onScroll);
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.offset > 300 && !showFab.value) {
        showFab.value = true; // show button
      } else if (scrollController.offset <= 300 && showFab.value) {
        showFab.value = false; // hide button
      }
    });

    animationControllers = List.generate(
      projectList.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
    );

    animations = animationControllers
        .map(
          (controller) => Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          ),
        )
        .toList();

    // Zoom Animations (hover)
    zoomControllers = List.generate(
      projectList.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0.0, // MUST BE 0.0
        upperBound: 1.0, // MUST BE 1.0
      ),
    );

    zoomAnimations = zoomControllers
        .map(
          (controller) => Tween<double>(
            begin: 1.0,
            end: 1.05,
          ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        )
        .toList();
  }

  RxBool toggle = false.obs;

  /// Hover zoom in
  void zoomIn(int index) {
    zoomControllers[index].forward();
    update();
  }

  /// Hover zoom out
  void zoomOut(int index) {
    zoomControllers[index].reverse();
    update();
  }

  /// Flip forward or backward
  void toggleAnimation(int index, {bool forward = true}) {
    if (forward) {
      animationControllers[index].forward();
    } else {
      animationControllers[index].reverse();
    }
    update();
  }

  /// Tap → flip card
  void toggleAnimation1(int index) {
    if (animationControllers[index].isCompleted) {
      animationControllers[index].reverse();
    } else {
      animationControllers[index].forward();
    }
    update();
  }

  @override
  void onClose() {
    for (var controller in animationControllers) {
      controller.dispose();
    }
    for (var controller in zoomControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  List<ProjectItem> projectList = [
    ProjectItem(
      image: "assets/images/restasmart_application.png",
      heading: "Restaurant Management",
      description:
          "A Restaurant Management System with POS and User Reporting is a robust solution designed to streamline restaurant operations, enhance customer service, and optimize sales tracking. The system integrates a Point of Sale (POS) module for order processing, billing, and inventory management, ensuring seamless transactions across multiple devices like tablets, Android, Windows, and web platforms. It includes user reporting features that provide insights into staff performance, sales trends, customer preferences, and financial summaries. Managers can generate detailed reports on daily sales, expenses, stock usage, and employee activities, helping them make data-driven decisions. With role-based access, restaurant owners, cashiers, and waiters can efficiently manage operations, improving efficiency and profitability.",
    ),
    ProjectItem(
      image: "assets/images/inventory.png",
      heading: "Inventory Management",
      description:
          "The Inventory Management System is a centralized solution designed to efficiently manage stock levels, product data, and material movements across various departments. It helps businesses maintain accurate inventory records, automate stock adjustments, and ensure timely replenishment through real-time tracking.The system includes key modules such as Item Management, Group Item Classification, Material Requests, Price Lists, Stock Adjustments, and Delivery Management, all working together to provide a complete inventory workflow. It supports dynamic data synchronization with cloud databases and ensures that updates in stock quantities, pricing, and transactions reflect instantly across the platform.Built to handle both mobile and web interfaces, the system offers a user-friendly dashboard for monitoring inventory performance, reducing manual errors, and improving operational efficiency.",
    ),

    ProjectItem(
      heading: "RestaSmart website",
      image: "assets/images/restasmart_website.png",
      description:
          "RestaSmart is a restaurant management application that simplifies operations. It offers features like POS, inventory management, employee scheduling, and CRM. The platform enhances efficiency, reduces complexities, and boosts productivity. Businesses can request a demo on the official website to explore its functionalities. RestaSmart provides flexible pricing based on business size and needs. Specific pricing details are available upon request. The application improves resource management and customer satisfaction. It helps restaurant owners streamline daily tasks effectively. RestaSmart supports business growth and increased profitability. It’s a powerful tool for modern restaurant management.",
    ),
    ProjectItem(
      image: "assets/images/kars_admin.png",
      heading: "KARS Admin",

      description:
          "An Organization Management System for a Training Institute like the Kuwait Amateurs Radio Society is designed to efficiently manage training programs, trainers, memberships, and payments. The system allows trainers to register, enroll in courses, track their progress, and complete training before becoming eligible for membership. It also includes membership management features, enabling members to apply, renew, and make payments online. Automated reports provide insights into training completion rates, membership status, payment history, and engagement levels. With role-based access for administrators, trainers, and members, the system enhances transparency, streamlines operations, and ensures a smooth training-to-membership transition.",
    ),
    ProjectItem(
      heading: "KARS Websites",
      image: "assets/images/kars_website.png",
      description:
          "The Kuwait Amateur Radio Society (KARS), founded in 1979, promotes amateur radio activities in Kuwait. It offers training courses for licensing exams and organizes local and international competitions. The society’s website provides training registration, news, events, and member details. KARS is affiliated with the International Amateur Radio Union (IARU) and issues special call signs for national events. Membership categories include active, ordinary, and honorary members. The headquarters feature advanced radio equipment, a library, and a postal office. KARS engages in community outreach to promote amateur radio. It collaborates with global radio societies to enhance knowledge-sharing. The society actively participates in national celebrations. KARS plays a crucial role in sustaining Kuwait’s amateur radio culture.",
    ),
    ProjectItem(
      heading: "Ummati",
      image: "assets/images/ummati.png",
      description:
          "The Ummati App is a feature-rich Islamic lifestyle application designed to support the spiritual and daily needs of the Muslim community. It offers essential tools such as an Imaan Tracker, accurate prayer timings, and a Qibla Finder—especially useful when traveling. Users can also locate nearby masjids with ease, view real-time weather conditions along with the Hijri date, and access a user-friendly Quran reader and a wide collection of Hadiths. With its intuitive design and practical features, the app serves as a valuable companion for Muslims around the world.",
    ),

    // Add more items...
  ];
}

class ProjectItem {
  final String image;
  final String heading;
  final String description;

  ProjectItem({
    required this.image,
    required this.heading,
    required this.description,
  });
}
