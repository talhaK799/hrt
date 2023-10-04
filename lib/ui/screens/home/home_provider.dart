import 'package:flutter/material.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeProvider extends BaseViewModel {
  int currentIndex = 0;
  bool isLiked = false;
  bool isRecent = false;
  SfRangeValues ageValues = SfRangeValues(18, 30);
  SfRangeValues distanceValues = SfRangeValues(3, 50);
  PageController? pageController;

  HomeProvider() {
    pageController = PageController(initialPage: 0);
    notifyListeners();
  }

  updateIndex(index) {
    currentIndex = index;
    print('current index==> $index=====> $currentIndex');
    notifyListeners();
  }

  changePage() {
    isLiked = false;
    notifyListeners();
  }

  like() {
    isLiked = true;

    pageController!.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  disLike() {
    isLiked = false;

    pageController!.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  recent(val) {
    isRecent = val;
    notifyListeners();
  }

  selectAge(values) {
    ageValues = values;
    notifyListeners();
  }

  selectDistance(values) {
    distanceValues = values;
    notifyListeners();
  }
}
