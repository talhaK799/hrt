import 'package:hart/core/models/chat.dart';
import 'package:hart/core/models/radio_button.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class ChattingProvider extends BaseViewModel {
  List<Chat> chats = [
    Chat(
      name: 'Group',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
      isGroup: true,
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
    Chat(
      name: 'Joseph',
      desscription: 'Lorem ipsum dolor sit amet consectet.',
    ),
  ];

  List<RadioButton> buttons = [
    RadioButton(
      title: 'Not my type',
    ),
    RadioButton(
      title: 'Fake/spam',
    ),
    RadioButton(
      title: 'Under age',
    ),
    RadioButton(
      title: 'Offensive',
    ),
    RadioButton(
      title: 'Soliciting',
    ),
  ];

  selectButton(index) {
    for (var i = 0; i < buttons.length; i++) {
      if (index == i) {
        buttons[i].isSelected = true;
      } else {
        buttons[i].isSelected = false;
      }
    }
    notifyListeners();
  }
}
