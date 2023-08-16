import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:diu_project1/lib3/books/pdf.dart';
import 'package:diu_project1/lib3/books/pdfBio.dart';
import 'package:diu_project1/lib3/books/pdfEng.dart';
import 'package:diu_project1/lib3/books/pdfHis.dart';
import 'package:diu_project1/lib3/books/pdfMath.dart';
import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/LoginPage.dart';


class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

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

class _BookListPageState extends State<BookListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.new_color,
        title: const Text("Books Item",style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22),),
        centerTitle: true,
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
      ),
      body: Container(
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 20,
                color: Colors.white60,
                child:
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Pdf(
                              )));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 25,
                      child: Text("Ba",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
                    ),
                    title: const Text(
                      "Bangla Literature ",
                      style: TextStyle(fontSize: 20)
                    ),
                    subtitle: Text(
                      "Read Bangla books when you need",
                      style: TextStyle(fontSize: 10)
                    ),
                    trailing: Image.asset("images/bangla.jpg")
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 20,
                color: Colors.white60,
                child:
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PdfEng(
                              )));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 25,
                      child: Text("En",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
                    ),
                    title: const Text(
                      "English Literature",
                      style: TextStyle(fontSize: 20)
                    ),
                    subtitle: Text(
                      "Read English books when you need",
                      style: TextStyle(fontSize: 10)
                    ),
                    trailing: Image.asset("images/english.jpg")
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 20,
                color: Colors.white60,
                child:
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PdfMath(
                              )));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 25,
                      child: Text("Ma",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
                    ),
                    title: const Text(
                      "Mathematics",
                      style: TextStyle(fontSize: 22)
                    ),
                    subtitle: Text(
                      "Read Math books when you need",
                      style: TextStyle(fontSize: 10)
                    ),
                    trailing: Image.asset("images/math.jpg",scale: 10,)
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 20,
                color: Colors.white60,
                child:
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PdfHis(
                              )));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 25,
                      child: Text("Hi",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
                    ),
                    title: Text(
                      "Historical",
                      style: TextStyle(fontSize: 22)
                    ),
                    subtitle: Text(
                      "Read Historical books when you need",
                      style: TextStyle(fontSize: 10)
                    ),
                    trailing: Image.asset("images/history.jpg",scale: 10,)
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 20,
                color: Colors.white60,
                child:
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PdfBio(
                              )));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 25,
                      child: Text("Bio",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
                    ),
                    title: const Text(
                      "Biographical",
                      style: TextStyle(fontSize: 22)
                    ),
                    subtitle: const Text(
                      "Read Biographical books when you need",
                      style: TextStyle(fontSize: 10)
                    ),
                    trailing: Image.asset("images/bio.jpg",scale: 10,)
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
