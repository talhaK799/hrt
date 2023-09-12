import 'package:flutter/material.dart';
import 'package:hart/core/models/onboarding.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class OnboardingViewModel extends BaseViewModel {
  // final Logger log = Logger();
  PageController? pageController;
  int currentPageIndex = 0;
  bool isShowStartedButton = false;

  OnboardingViewModel() {
    // currentPageIndex = _localStorageService.onBoardingPageCount;
    pageController = PageController(initialPage: currentPageIndex);
    notifyListeners();
  }
  List<Onboarding> onboardingList = [
    Onboarding(
      title: "Find your spouse with Hart",
      description:
          "Users going through a vetting process to ensure your never matchs with bots.",
      // imgUrl: "$staticImages/onboarding_01.png",
    ),
    Onboarding(
      title: "Find your spouse with Hart",
      description:
          "Users going through a vetting process to ensure your never matchs with bots.",
      // imgUrl: "$staticImages/onboarding_02.png",
    ),
    Onboarding(
      title: "Find your spouse with Hart",
      description:
          "Users going through a vetting process to ensure your never matchs with bots.",
      // imgUrl: "$staticImages/onboarding_03.png",
    ),
  ];
  // final _localStorageService = locator<LocalStorageService>();

  updatePage(index) {
    // log.d('@updateOnboarding page with index: $index');
    currentPageIndex = index;
    if (currentPageIndex == onboardingList.length - 1) {
      isShowStartedButton = true;
    } else {
      isShowStartedButton = false;
    }
    // _localStorageService.onBoardingPageCount = index;
    notifyListeners();
  }

  updatePageFromButton() {
    // pageController.page
    if (currentPageIndex < onboardingList.length - 1) {
      currentPageIndex++;
      pageController!.animateToPage(
        currentPageIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
      if (currentPageIndex == onboardingList.length - 1) {
        isShowStartedButton = true;
      } else {
        isShowStartedButton = false;
      }
    } else {
      isShowStartedButton = true;
    }
    // _localStorageService.onBoardingPageCount = currentPageIndex;
    notifyListeners();
  }
}
