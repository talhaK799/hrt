import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkStatusService {
  final _internetConection = InternetConnectionChecker();
  bool hasConnection = false;
  NetworkStatusService() {
    init();
  }

  init() async {
    var listener = _internetConection.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          hasConnection = true;
          break;
        case InternetConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          hasConnection = false;
          break;
      }
    });
    // close listener after 30 seconds, so the program doesn't run forever
    await Future.delayed(Duration(seconds: 30));
    await listener.cancel();
  }
}
