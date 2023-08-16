import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:diu_project1/lib3/books/book_list.dart';
import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:diu_project1/lib3/notes/note_page.dart';
import 'package:diu_project1/lib3/pages/my_post.dart';
import 'package:diu_project1/lib3/profile/profile.dart';
import 'package:diu_project1/models/UserModel.dart';
import 'package:diu_project1/pages/search_subject.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter/material.dart';
import '../lib3/chat/chatpage.dart';
import '../lib3/custom_wigets/main_drawer.dart';
import '../lib3/custom_wigets/slider_screen.dart';
import '../lib3/custom_wigets/teacher_scrolling.dart';
import '../lib3/pages/favourite.dart';
import '../lib3/pages/student_information.dart';
import 'LoginPage.dart';
import 'chat_request.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const HomePage({super.key, required this.userModel, required this.firebaseUser});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
      drawer: MainDrawer(
        userModel: widget.userModel,
        firebaseUser: widget.firebaseUser,
      ),
      appBar: AppBar(
        backgroundColor:  const Color(0xff73c5e0),
        // centerTitle: true,
        title: AnimatedTextKit(animatedTexts: [
          WavyAnimatedText(
            "TuitionFinder",
            textStyle: const TextStyle( fontWeight: FontWeight.w400,fontSize: 22),
            speed: const Duration(milliseconds: 1000),

          ),
        ],
        repeatForever: true,
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SearchSubjectPage(
                    //userModel: widget.userModel, firebaseUser: widget.firebaseUser

                  );
                }),
              );
            },
            icon: const Icon(Icons.search),
          ),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 30,
                child: Marquee(text:
                "Discover, Connect, and Excel in Tuition with Tuition Finder!",
                  blankSpace: 50,
                  pauseAfterRound: const Duration(seconds: 1),
                  style: const TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                      // color: Colors.bla,
                      fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(
                  height: 90,
                  child: SliderScreen()),
            ],
          ),
        ),
        // bottom: PreferredSize(
        //   child: Column(
        //     children: [
        //
        //
        //     ],
        //   ),
        //   preferredSize: Size.fromHeight(80),
        // ),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           colors: [Colors.deepPurple, Colors.deepOrange]),
        //       borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(100),
        //         bottomRight: Radius.circular(100),
        //       )),
        // ),
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //       // bottomLeft: Radius.circular(100),
        //       bottomRight: Radius.circular(100),
        //     )),
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await FirebaseAuth.instance.signOut();
        //       Navigator.popUntil(context, (route) => route.isFirst);
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) {
        //             return LoginPage();
        //           }
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.exit_to_app),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Container(
          color:  const Color(0xff73c5e0),
      //width: 300,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/ 5.7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
                crossAxisCount: 4,
            childAspectRatio: 1.4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: [

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MyPost(

                          )));


                },
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/teacher3.png",height: 20,width: 20,),
                    const Text(
                      "My Post",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      ),
                    ),

                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChatRequest(
                            userModel: widget.userModel,
                            firebaseUser: widget.firebaseUser,
                          )));
                },
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/teacher5.png",
                      height: 20,
                      width: 20,
                    ),
                    const Text(
                      "Chat Request",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BookListPage(

                          )));


                },
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/teacher4.png",height: 20,width: 20,),
                    const Text(
                      "Books",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      ),
                    ),

                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NotePage(
                            userModel: widget.userModel,
                            firebaseUser: widget.firebaseUser,
                          )));

                },
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/teacher5.png",height: 20,width: 20,),
                    const Text(
                      "Notes",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      ),
                    ),

                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Profile(
                            userModel: widget.userModel,
                            firebaseUser: widget.firebaseUser,
                          )));

                },
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/teacher6.png",height: 20,width: 20,),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      ),
                    ),

                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
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
                                color: AppColors.new_color,
                                elevation: 20,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => chatpage(
                                              userModel:
                                              widget.userModel,
                                              firebaseUser:
                                              widget.firebaseUser,
                                            )));
                                  },
                                  leading: const Icon(Icons.chat,color: Colors.black,),
                                  title: const Text(
                                    "Click for Group Chat",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                                ),
                              ),
                              Card(
                                color: AppColors.new_color,
                                elevation:10,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  leading: const Icon(Icons.watch_later,color: Colors.black,),
                                  title: const Text("Later",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/teacher7.png",
                      height: 20,
                      width: 20,
                    ),
                    const Text(
                      "Group Chat",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Favourite(
                            userModel: widget.userModel,
                            firebaseUser: widget.firebaseUser,
                          )));

                },
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/teacher8.png",height: 20,width: 20,),
                    const Text(
                      "Favourite",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      ),
                    ),

                  ],
                ),
              ),

            ],
            ),
          ),
          ),
          Container(
              color:  const Color(0xff73c5e0),
            child: Column(
              children: [
                Container(
                  //color:  Color(0xff73c5e0),
                  //width: 300,
                  width: MediaQuery.of(context).size.width,
                  //height: 300,
                  height: MediaQuery.of(context).size.height/1.8,

                  decoration: const BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )
                  ),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.blue[50],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          onTap:()=> Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => StudentInformation(
                                    userModel: widget.userModel,
                                    firebaseUser: widget.firebaseUser,
                                  ))),
                          leading: CircleAvatar(

                            child: Image.asset("images/s1.png"),
                          ),
                          title: const Text("Need Tutor?"),
                          subtitle: const Text("Submit a Tutor Request"),
                          trailing: const Icon(Icons.arrow_forward_sharp,color: AppColors.new_color,),
                        ),

                      ),
                      Container(
                        alignment: Alignment.center,
                        // height: MediaQuery.of(context).size.height,
                        //   width: MediaQuery.of(context).size.width,
                        height: 24,
                          width: 400,
                          decoration: BoxDecoration(
                              //color: Colors.white,
                              color: Colors.blue[50],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)
                              ),
                          ),
                        //color: Colors.blue[50],
                        child:  AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              "Hire a TuTor ->",
                              textStyle: TextStyle(
                                color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              speed: Duration(milliseconds: 700),
                              colors: [
                                Colors.black54,
                                Colors.deepOrangeAccent,
                                Colors.amber
                              ],
                            ),
                          ],
                          repeatForever: true,
                        ),
                        // Text("Hire a TuTor ->",style: TextStyle(
                        //     fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45
                        // ),),


                      ),
                      Container(
                          decoration: BoxDecoration(
                            //color: Colors.white,
                              color: Colors.blue[50],
                              borderRadius: const BorderRadius.only(
                                //topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                //bottomRight: Radius.circular(20),
                              )
                          ),
                          height: MediaQuery.of(context).size.height/2.35,
                          width: MediaQuery.of(context).size.width,
                         // color: Colors.blue[50],
                          child: TeacherScroll(userModel: widget.userModel, firebaseUser: widget.firebaseUser,))
                    ],
                  ),


          ),

              ],
            ),


      ),

          ],
      )
    );
  }
}
// body: Padding(
//   padding: const EdgeInsets.all(15.0),
//   child:
// ),

// SafeArea(
//   child: Column(
//     //crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//
//       SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         physics: BouncingScrollPhysics(),
//         padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.black12,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15), //color: Colors.green
//                     bottomLeft: Radius.circular(15),
//                   ) //color: Colors.green
//                   ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Activity',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineMedium!
//                         .copyWith(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 5),
//                   SingleChildScrollView(
//                     physics: BouncingScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 200,
//                           width: 150,
//                           decoration: const BoxDecoration(
//                               color: Colors.yellow,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(20))),
//                           child: Column(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceAround,
//                             children: [
//                               Image.asset(
//                                 'images/s1.png',
//                                 height: 60,
//                                 width: 60,
//                               ),
//                               Text(
//                                 "For    Teachers",
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headline5,
//                               ),
//                               //ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios), label: Text("data"))
//                               //OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios), label: Text("data"))
//                               TextButton.icon(
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (_) =>
//                                                 TeacherInformation()));
//                                   },
//                                   icon: Icon(Icons.arrow_forward_ios),
//                                   label: Text("clcik hare"))
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         Container(
//                           height: 200,
//                           width: 150,
//                           decoration: const BoxDecoration(
//                               color: Colors.grey,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(20))),
//                           child: Column(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceAround,
//                             children: [
//                               Image.asset(
//                                 'images/s1.png',
//                                 height: 60,
//                                 width: 60,
//                               ),
//                               Text(
//                                 "For     Students",
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headline5,
//                               ),
//                               TextButton.icon(
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (_) =>
//                                                 StudentInformation()));
//                                   },
//                                   icon: Icon(Icons.arrow_forward_ios),
//                                   label: Text("clcik hare"))
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         Container(
//                           height: 200,
//                           width: 150,
//                           decoration: const BoxDecoration(
//                               color: Colors.orangeAccent,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(20))),
//                           child: Column(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceAround,
//                             children: [
//                               Image.asset(
//                                 'images/s1.png',
//                                 height: 60,
//                                 width: 60,
//                               ),
//                               Text(
//                                 "Notes",
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headline5,
//                               ),
//                               // TextButton.icon(
//                               //     onPressed: () {
//                               //       Navigator.push(
//                               //           context,
//                               //           MaterialPageRoute(
//                               //               builder: (_) =>
//                               //                   NotePage()));
//                               //     },
//                               //     icon: Icon(Icons.arrow_forward_ios),
//                               //     label: Text("clcik hare"))
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         Container(
//                           height: 200,
//                           width: 150,
//                           decoration: const BoxDecoration(
//                               color: Colors.blueGrey,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(20))),
//                           child: Column(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceAround,
//                             children: [
//                               Image.asset(
//                                 'images/s1.png',
//                                 height: 60,
//                                 width: 60,
//                               ),
//                               Text(
//                                 "Courses",
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headline5,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.black12,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15), //color: Colors.green
//                     bottomLeft: Radius.circular(15),
//                   ) //color: Colors.green
//                   ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Find Your Tutor',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineMedium!
//                         .copyWith(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 5),
//                   //TeacherScroll(),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.black12,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15), //color: Colors.green
//                     topRight: Radius.circular(15), //color: Colors.green
//                     bottomLeft: Radius.circular(15),
//                   ) //color: Colors.green
//                   ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Find Your Tutee',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineMedium!
//                         .copyWith(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 5),
//                   // StudentScrolling(userModel: widget.userModel,
//                   //     firebaseUser: widget.firebaseUser),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),

// body: SafeArea(
//   child: Container(
//     child: StreamBuilder(
//       stream: FirebaseFirestore.instance.collection("chatrooms").where("participants.${widget.userModel.uid}", isEqualTo: true).snapshots(),
//       builder: (context, snapshot) {
//         if(snapshot.connectionState == ConnectionState.active) {
//           if(snapshot.hasData) {
//             QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;
//
//             return ListView.builder(
//               itemCount: chatRoomSnapshot.docs.length,
//               itemBuilder: (context, index) {
//                 ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(chatRoomSnapshot.docs[index].data() as Map<String, dynamic>);
//
//                 Map<String, dynamic> participants = chatRoomModel.participants!;
//
//                 List<String> participantKeys = participants.keys.toList();
//                 participantKeys.remove(widget.userModel.uid);
//
//                 return FutureBuilder(
//                   future: FirebaseHelper.getUserModelById(participantKeys[0]),
//                   builder: (context, userData) {
//                     if(userData.connectionState == ConnectionState.done) {
//                       if(userData.data != null) {
//                         UserModel targetUser = userData.data as UserModel;
//
//                         return ListTile(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) {
//                                 return ChatRoomPage(
//                                   chatroom: chatRoomModel,
//                                   firebaseUser: widget.firebaseUser,
//                                   userModel: widget.userModel,
//                                   targetUser: targetUser,
//                                 );
//                               }),
//                             );
//                           },
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(targetUser.profilepic.toString()),
//                           ),
//                           title: Text(targetUser.fullname.toString()),
//                           subtitle: (chatRoomModel.lastMessage.toString() != "") ? Text(chatRoomModel.lastMessage.toString()) : Text("Say hi to your new friend!", style: TextStyle(
//                             color: Theme.of(context).colorScheme.secondary,
//                           ),),
//                         );
//                       }
//                       else {
//                         return Container();
//                       }
//                     }
//                     else {
//                       return Container();
//                     }
//                   },
//                 );
//               },
//             );
//           }
//           else if(snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           }
//           else {
//             return Center(
//               child: Text("No Chats"),
//             );
//           }
//         }
//         else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     ),
//   ),
// ),
// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return SearchPage(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
//     }));
//   },
//   child: Icon(Icons.search),
// ),