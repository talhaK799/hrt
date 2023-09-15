import 'package:hart/core/models/chat_message.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class ConversationProvider extends BaseViewModel {
  List<ChatMessage> messages = [
    ChatMessage(
      text:
          'Lorem ipsum dolor sit amet consecte tur. Dui blandit id eget felis nunc amet. Cursus at vitae dignissim vivamus a adipiscing.',
      isSender: true,
    ),
    ChatMessage(
      text:
          'Lorem ipsum dolor sit amet consecte tur. Dui blandit id eget felis nunc amet. Cursus at vitae dignissim vivamus a adipiscing.',
    ),
    ChatMessage(
      text:
          'Lorem ipsum dolor sit amet consecte tur. Dui blandit id eget felis nunc amet. Cursus at vitae dignissim vivamus a adipiscing.',
      isSender: true,
    ),
    ChatMessage(
      text:
          'Lorem ipsum dolor sit amet consecte tur. Dui blandit id eget felis nunc amet. Cursus at vitae dignissim vivamus a adipiscing.',
    )
  ];
}
