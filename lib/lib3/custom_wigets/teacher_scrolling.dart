import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/UserModel.dart';
import '../../pages/SearchPage.dart';
import '../const/app_color.dart';
import '../pages/teacher_details_page.dart';

class TeacherScroll extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  TeacherScroll({required this.userModel, required this.firebaseUser});

  @override
  State<TeacherScroll> createState() => _TeacherScrollState();
}

class _TeacherScrollState extends State<TeacherScroll> {
  List _teacher = [];
  //List _image = [];
  var fireStoreInstance = FirebaseFirestore.instance;
  fetchTeacher() async {
    QuerySnapshot qn = await fireStoreInstance.collection("teachers").orderBy("time",descending: true).get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _teacher.add({
          "teacher-name": qn.docs[i]["name"],
          "teacher-email": qn.docs[i]["email"],
          "teacher-address": qn.docs[i]["address"],
          "teacher-phone": qn.docs[i]["phone"],
          "teacher-gender": qn.docs[i]["gender"],
          "teacher-dob": qn.docs[i]["dob"],
          "teacher-age": qn.docs[i]["age"],
          "teacher-details": qn.docs[i]["details"],
          "teacher-department": qn.docs[i]["department"],
          "teacher-institute": qn.docs[i]["institute"],
          "teacher-subject": qn.docs[i]["subject"],
          "teacher-class": qn.docs[i]["class"],
          "proimg": qn.docs[i]['profileTea'],
        });
      }
    });
  }

  // fetchImage() async {
  //   QuerySnapshot qn = await fireStoreInstance.collection("users").get();
  //   setState(() {
  //     for (int i = 0; i < qn.docs.length; i++) {
  //       _image.add({
  //         "proimg": qn.docs[i]['profilepic'],
  //       });
  //     }
  //   });
  //   return qn.docs;
  // }

  @override
  void initState() {
    fetchTeacher();
    //fetchImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text("Teacher's Info",
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 25),),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //   ),
    //   body:Container(
    //       padding: EdgeInsets.only(top: 90),
    //       decoration: BoxDecoration(
    //           color: Colors.lightBlue
    //         // gradient: LinearGradient(colors: [
    //         //   Colors.deepPurple,
    //         //   Colors.deepOrange
    //         // ])
    //       ),
    //       //color: Colors.red,
    //       child:
    //         Container(
    //         decoration: BoxDecoration(
    //             color: Colors.blue[50],
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(50),
    //               topRight: Radius.circular(50),
    //
    //             )
    //         ),
    //         height: MediaQuery.of(context).size.height,
    //         width: MediaQuery.of(context).size.width,
    //         child:
            GridView.builder(
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,childAspectRatio: .8,
              mainAxisSpacing: 0,crossAxisSpacing: 2) ,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _teacher.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4,left: 10,right: 0,bottom: 0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.blue[50],
                              title: const Center(child: Text("Choose an Option",style: TextStyle(color: AppColors.new_color),)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Card(
                                    color:AppColors.new_color,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    TeacherDetailsPage(
                                                      _teacher[index],
                                                      userModel:
                                                      widget.userModel,
                                                      firebaseUser:
                                                      widget.firebaseUser,
                                                    )));
                                      },
                                      // leading: const Icon(Icons.request_page,color: Colors.white,),
                                      title: const Center(
                                        child: Text(
                                          "Teacher Details",style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,),),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: AppColors.new_color,
                                    elevation: 20,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return SearchPage(
                                                    _teacher[index],
                                                      userModel:
                                                      widget.userModel,
                                                      firebaseUser: widget
                                                          .firebaseUser);
                                                }));
                                      },
                                      // leading: const Icon(Icons.watch_later,color:Colors.white,),
                                      title: const Center(child: Text("Chat with Teacher",style: TextStyle(fontWeight: FontWeight.w500,),)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (_) => TeacherDetailsPage(
                    //               _teacher[index],
                    //               userModel: widget.userModel,
                    //               firebaseUser: widget.firebaseUser)));
                    // },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(_teacher[index]['proimg'])
                              ),
                            ),
                            Container(
                              height: 18,
                              child: Text(_teacher[index]["teacher-name"],
                                  style: const TextStyle(fontSize: 10,color: Colors.blue,
                                      fontWeight:FontWeight.bold )),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.book,size: 15,),
                                const SizedBox(width: 3,),
                                Container(alignment: Alignment.centerLeft,
                                  height: 30,
                                  width: 148,
                                  child: Text(_teacher[index]["teacher-department"],
                                      style: const TextStyle(fontSize: 10)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.school,size: 15,),
                                const SizedBox(width: 3,),
                                Container(alignment: Alignment.centerLeft,
                                  height: 42,
                                  width: 148,
                                  child: Text(_teacher[index]["teacher-institute"],
                                      style: const TextStyle(fontSize: 10)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     radius: 25,
                      //     child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(25),
                      //         child: Image.network(_teacher[index]['proimg'])
                      //     ),
                      //   ),
                      //   title: Text(_teacher[index]["teacher-name"],
                      //       style: TextStyle(fontSize: 25)),
                      //   subtitle: Text(_teacher[index]["teacher-department"],
                      //       style: TextStyle(fontSize: 18)),
                      //   trailing: IconButton(
                      //       onPressed: (){},
                      //       icon: Icon(Icons.arrow_forward_ios)),
                      // ),
                    ),
                  ),
                );
              },
            //)
            );
    //       )
    //   )
    //
    // );
  }
}
