import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/UserModel.dart';
import '../../pages/LoginPage.dart';
import '../const/app_color.dart';
import '../custom_wigets/fetchdata.dart';

class Favourite extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const Favourite({super.key,
    required this.userModel,
    required this.firebaseUser,
  });
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {

  void onSelected(BuildContext context, item) {
    switch (item) {
      case 1:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.TOPSLIDE,
          showCloseIcon: true,
          btnOkText: 'Yes',
          btnCancelText: 'No',
          title: "Warning",
          desc: "Do You want to LogOut?",
          btnCancelOnPress: () {
            //Navigator.pop(context);
          },
          btnOkOnPress: () {
            //Navigator.pop(context);
            FirebaseAuth.instance.signOut();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => LoginPage(
                      // userModel: userModel, firebaseUser: firebaseUser,
                    )));
          },
        ).show();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Favourite List",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),

          ),
          actions: [
            PopupMenuButton<int>(
              // color: Colors.black,
                onSelected: (item) => onSelected(context, item),
                color: Colors.black,
                itemBuilder: (context) =>
                [
                  // PopupMenuItem(value: 0,
                  //   child: Text("Search",)),
                  const PopupMenuItem(value: 1,
                      child: Text("Log Out",style: TextStyle(color: Colors.white),)),

                ]),

          ],
          //backgroundColor: Colors.transparent,
          backgroundColor: AppColors.new_color,
          elevation: 0,
        ),
         body: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[50],
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: fetchData("users_favourite"),
            )
    );
  }
}
