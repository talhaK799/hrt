import 'package:hart/core/view_models/base_view_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeProvider extends BaseViewModel {
  int currentIndex = 0;
  bool isLiked = false;
  SfRangeValues ageValues = SfRangeValues(18, 30);
  SfRangeValues distanceValues = SfRangeValues(3, 10);

  updateIndex(index) {
    currentIndex = index;
    print('current index==> $index=====> $currentIndex');
    notifyListeners();
  }

  like() {
    isLiked = !isLiked;
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
