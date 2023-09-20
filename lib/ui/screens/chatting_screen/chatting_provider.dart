import 'package:hart/core/models/chat.dart';
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
}
