// // lib/controllers/main_navigation_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class MainNavigationController extends GetxController with GetTickerProviderStateMixin {
//   final currentIndex = 0.obs;
//   final isBottomNavVisible = true.obs;
//
//   late ScrollController dashboardScrollController;
//   late ScrollController profileScrollController;
//   late AnimationController bottomNavAnimationController;
//   late Animation<Offset> bottomNavAnimation;
//
//   double lastScrollOffset = 0.0;
//
//   @override
//   void onInit() {
//     super.onInit();
//     initializeControllers();
//     setupScrollListeners();
//   }
//
//   void initializeControllers() {
//     dashboardScrollController = ScrollController();
//     profileScrollController = ScrollController();
//
//     bottomNavAnimationController = AnimationController(
//       duration: Duration(milliseconds: 300),
//       vsync: this,
//     );
//
//     bottomNavAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: Offset(0.0, 1.0),
//     ).animate(CurvedAnimation(
//       parent: bottomNavAnimationController,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   void setupScrollListeners() {
//     dashboardScrollController.addListener(() => handleScroll(dashboardScrollController));
//     profileScrollController.addListener(() => handleScroll(profileScrollController));
//   }
//
//   void handleScroll(ScrollController controller) {
//     if (controller.hasClients) {
//       double currentScrollOffset = controller.offset;
//       double delta = currentScrollOffset - lastScrollOffset;
//
//       // Hide bottom nav when scrolling down, show when scrolling up
//       if (delta > 5 && isBottomNavVisible.value) {
//         hideBottomNav();
//       } else if (delta < -5 && !isBottomNavVisible.value) {
//         showBottomNav();
//       }
//
//       lastScrollOffset = currentScrollOffset;
//     }
//   }
//
//   void hideBottomNav() {
//     isBottomNavVisible.value = false;
//     bottomNavAnimationController.forward();
//   }
//
//   void showBottomNav() {
//     isBottomNavVisible.value = true;
//     bottomNavAnimationController.reverse();
//   }
//
//   void changeTab(int index) {
//     currentIndex.value = index;
//     // Reset scroll position when switching tabs
//     showBottomNav();
//   }
//
//   ScrollController getCurrentScrollController() {
//     return currentIndex.value == 0 ? dashboardScrollController : profileScrollController;
//   }
//
//   @override
//   void onClose() {
//     dashboardScrollController.dispose();
//     profileScrollController.dispose();
//     bottomNavAnimationController.dispose();
//     super.onClose();
//   }
// }
// lib/controllers/main_navigation_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController with GetTickerProviderStateMixin {
  final currentIndex = 0.obs;
  final isBottomNavVisible = true.obs;

  late ScrollController dashboardScrollController;
  late ScrollController profileScrollController;
  late AnimationController bottomNavAnimationController;
  late Animation<Offset> bottomNavAnimation;

  double lastScrollOffset = 0.0;
  bool _listenersAttached = false;

  @override
  void onInit() {
    super.onInit();
    initializeControllers();
    setupScrollListeners();
  }

  @override
  void onReady() {
    super.onReady();
    // Ensure listeners are attached when controller is ready
    if (!_listenersAttached) {
      setupScrollListeners();
    }
  }

  void initializeControllers() {
    dashboardScrollController = ScrollController();
    profileScrollController = ScrollController();

    bottomNavAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    bottomNavAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: bottomNavAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  void setupScrollListeners() {
    // Remove existing listeners first to prevent duplicates
    removeScrollListeners();

    dashboardScrollController.addListener(_dashboardScrollListener);
    profileScrollController.addListener(_profileScrollListener);
    _listenersAttached = true;
  }

  void removeScrollListeners() {
    if (_listenersAttached) {
      dashboardScrollController.removeListener(_dashboardScrollListener);
      profileScrollController.removeListener(_profileScrollListener);
      _listenersAttached = false;
    }
  }

  void _dashboardScrollListener() {
    if (currentIndex.value == 0) {
      handleScroll(dashboardScrollController);
    }
  }

  void _profileScrollListener() {
    if (currentIndex.value == 1) {
      handleScroll(profileScrollController);
    }
  }

  void handleScroll(ScrollController controller) {
    if (controller.hasClients && controller.positions.isNotEmpty) {
      double currentScrollOffset = controller.offset;
      double delta = currentScrollOffset - lastScrollOffset;

      // Only process scroll if the offset change is significant
      if (delta.abs() > 1.0) {
        // Hide bottom nav when scrolling down, show when scrolling up
        if (delta > 5 && isBottomNavVisible.value) {
          hideBottomNav();
        } else if (delta < -5 && !isBottomNavVisible.value) {
          showBottomNav();
        }

        lastScrollOffset = currentScrollOffset;
      }
    }
  }

  void hideBottomNav() {
    if (isBottomNavVisible.value) {
      isBottomNavVisible.value = false;
      bottomNavAnimationController.forward();
    }
  }

  void showBottomNav() {
    if (!isBottomNavVisible.value) {
      isBottomNavVisible.value = true;
      bottomNavAnimationController.reverse();
    }
  }

  void changeTab(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      // Reset scroll position when switching tabs
      showBottomNav();
      // Reset last scroll offset for the new tab
      lastScrollOffset = getCurrentScrollController().hasClients
          ? getCurrentScrollController().offset
          : 0.0;
    }
  }

  ScrollController getCurrentScrollController() {
    return currentIndex.value == 0 ? dashboardScrollController : profileScrollController;
  }

  // Method to refresh listeners if needed
  void refreshScrollListeners() {
    setupScrollListeners();
  }

  // ADD THIS METHOD: Reset to dashboard after login
  void resetToDashboard() {
    currentIndex.value = 0;
    isBottomNavVisible.value = true;
    lastScrollOffset = 0.0;

    // Reset animation controller to initial state
    bottomNavAnimationController.reset();

    // Reset scroll positions
    if (dashboardScrollController.hasClients) {
      dashboardScrollController.jumpTo(0);
    }
    if (profileScrollController.hasClients) {
      profileScrollController.jumpTo(0);
    }
  }

  @override
  void onClose() {
    removeScrollListeners();
    dashboardScrollController.dispose();
    profileScrollController.dispose();
    bottomNavAnimationController.dispose();
    super.onClose();
  }
}