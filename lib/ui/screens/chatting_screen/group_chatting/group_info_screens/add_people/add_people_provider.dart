import 'package:hart/core/models/group_members.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class AddPeopleProvider extends BaseViewModel {
  bool isEnable = false;
  List<GroupMembers> memebers = [
    GroupMembers(
      name: 'laiba',
      description: '20 woman straight',
    ),
    GroupMembers(
      name: 'laiba',
      description: '20 woman straight',
    ),
    GroupMembers(
      name: 'laiba',
      description: '20 woman straight',
    ),
    GroupMembers(
      name: 'laiba',
      description: '20 woman straight',
    ),
    GroupMembers(
      name: 'laiba',
      description: '20 woman straight',
    ),
    GroupMembers(
      name: 'laiba',
      description: '20 woman straight',
    ),
  ];
  check(ind) {
    memebers[ind].isChecked = !memebers[ind].isChecked!;
    for (var i = 0; i < memebers.length; i++) {
      if (memebers[i].isChecked == true) {
        isEnable = true;
        break;
      } else {
        isEnable = false;
      }
    }
    notifyListeners();
  }
}
