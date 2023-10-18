import 'package:flutter/material.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen.dart';
import 'package:hart/ui/screens/connection_screen/connection_screen.dart';
import 'package:hart/ui/screens/profile_screen/profile_screen.dart';
import '../../../core/view_models/base_view_model.dart';
import '../home/home_screen.dart';

class RootViewModel extends BaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedDate = 1;
  bool isSearch = false;
  String? selectedMonth;
  bool confirm = false;
  List<Widget> allScreen = [];
  int currentIndex = 0;

  RootViewModel() {
    allScreen = [
      HomeScreen(),
      ConnectionScreen(),
      ConversationScreen(),
      ProfileScreen(),
    ];
  }
  updateIndex(int index) async {
    currentIndex = index;

    notifyListeners();
  }

  isSearching(val) {
    isSearch = val;
    notifyListeners();
  }

  
}
