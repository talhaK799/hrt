import 'package:hart/core/models/group_members.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class CreateGroupProvider extends BaseViewModel {
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
    notifyListeners();
  }
}
