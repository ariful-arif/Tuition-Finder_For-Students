// import 'package:diu_project1/models/UserModel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class BottomNavigationController extends StatefulWidget {
//   const BottomNavigationController(
//       {super.key, required UserModel userModel, required User firebaseUser});
//
//   @override
//   State<BottomNavigationController> createState() =>
//       _BottomNavigationControllerState();
// }
//
// class _BottomNavigationControllerState
//     extends State<BottomNavigationController> {
//   //final _pages = [ Profile(), About(), NotePage()];
//   int _currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 5,
//         selectedItemColor: Color(0xFFFF6B6B),
//         backgroundColor: Colors.white10,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         selectedLabelStyle:
//             TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info),
//             label: "About",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.note),
//             label: "Notes",
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//             print(_currentIndex);
//           });
//         },
//       ),
//     );
//   }
// }
