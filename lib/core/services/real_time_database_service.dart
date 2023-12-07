// import 'package:firebase_database/firebase_database.dart';
// import 'package:hart/core/models/app_user.dart';

// class RealtimeDatabaseService {
//   final _rdb = FirebaseDatabase.instance;

//   onlineStatus(AppUser appuser) async {
//     // Since I can connect from multiple devices, we store each connection
// // instance separately any time that connectionsRef's value is null (i.e.
// // has no children) I am offline.
//     final myConnectionsRef = _rdb.ref(appuser.id);

// // Stores the timestamp of my last disconnect (the last time I was seen online)
//     final lastOnlineRef = myConnectionsRef.child('lastOnline');

//     final connectedRef = _rdb.ref(".info/connected");
//     connectedRef.onValue.listen((event) {
//       appuser.isOnline = event.snapshot.value as bool? ?? false;

//       if (appuser.isOnline == true) {
//         final con = myConnectionsRef.child('isOnline');

//         // When this device disconnects, remove it.
//         con.onDisconnect().remove();

//         // When I disconnect, update the last time I was seen online.
//         lastOnlineRef.onDisconnect().set(DateTime.now());

//         // Add this device to my connections list.
//         // This value could contain info about the device or a timestamp too.
//         con.set(true);
//       }
//     });
//   }
// }
