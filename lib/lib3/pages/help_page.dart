import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/LoginPage.dart';
import '../const/app_color.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
      appBar: AppBar(
        title: Text("Help Contacts",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22)),
        centerTitle: true,
        backgroundColor: AppColors.new_color,
        actions: [
          PopupMenuButton<int>(
              // color: Colors.black,
              onSelected: (item) => onSelected(context, item),
              //color: Colors.black,
              itemBuilder: (context) => [
                    // PopupMenuItem(value: 0,
                    //   child: Text("Search",)),
                    PopupMenuItem(
                        value: 1,
                        child: Text(
                          "Log Out",
                        )),
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
                elevation: 10,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                      onTap: () {

                      },
                      leading: CircleAvatar(
                        radius: 25,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset("images/avater 1.png",fit: BoxFit.cover,height: 100,
                            )),
                      ),
                      title: Text("Md. Ariful Hasan",
                        style: TextStyle(color: AppColors.new_color),
                      ),
                      subtitle: Text(
                        "ariful123@gmail.com"
                        // "Subject : ${snapshot.data!.docChanges[index].doc['subject']}"
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.only(left: 12.0, top: 5),
                      child: Row(
                        children: [
                          Text(
                            "Address: ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.new_color),
                          ),
                          Container(
                            width: 260,
                            child: Text(
                              "Mirpur 1,Dhaka",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 12.0, top: 5),
                      child: Row(
                        children: [
                          Text(
                            "Phone: ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.new_color),
                          ),
                          Container(
                            width: 110,
                            child: Text(
                              "8801737907027",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }
                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: "ariful123@gmail.com",
                                    query:
                                    encodeQueryParameters(<String, String>{
                                      'subject':
                                      'Example Subject & Symbols are allowed!',
                                    }),
                                  );
                                  if (await canLaunchUrl(emailLaunchUri)) {
                                    launchUrl(emailLaunchUri);
                                  }
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: AppColors.new_color,
                                    ),
                                    Text("Email",style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                              ),

                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              final Uri call = Uri(
                                scheme: 'tel',
                                path: "8801737907027",);
                              if (await canLaunchUrl(call)) {
                                await launchUrl(call);
                              } else {
                                print("cant launch url");
                              }
                              ;
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ),
                                Text("call",style: TextStyle(fontSize: 10),)
                              ],
                            ),

                          ),
                          GestureDetector(
                              onTap: () async {
                                final Uri call = Uri(
                                  scheme:'sms',
                                  path: "8801737907027",);
                                if(await canLaunchUrl(call)){
                                  await launchUrl(call);
                                }else{
                                  print("cant launch url");
                                };

                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.sms,
                                    color: AppColors.new_color,
                                  ),
                                  Text("SMS",style: TextStyle(fontSize: 10),)
                                ],
                              )),
                          GestureDetector(
                              onTap: () async {
                                final Uri call = Uri(
                                  scheme:'sms',
                                  path: "8801737907027",);
                                if(await canLaunchUrl(call)){
                                  await launchUrl(call);
                                }else{
                                  print("cant launch url");
                                };

                              },
                              child: Column(
                                children: [
                                  FaIcon(FontAwesomeIcons.squareWhatsapp,color: Colors.green,),
                                  Text("WhatsApp",style: TextStyle(fontSize: 10),)
                                ],
                              )

                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                elevation: 10,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                      onTap: () {

                      },
                      leading: CircleAvatar(
                        radius: 25,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset("images/s1.png",fit: BoxFit.cover,height: 100,
                            )),
                      ),
                      title: Text("Md. Atikur Rahman",
                        style: TextStyle(color: AppColors.new_color),
                      ),
                      subtitle: Text(
                        "atikur199@gmail.com"
                        // "Subject : ${snapshot.data!.docChanges[index].doc['subject']}"
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.only(left: 12.0, top: 5),
                      child: Row(
                        children: [
                          Text(
                            "Address: ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.new_color),
                          ),
                          Container(
                            width: 260,
                            child: Text(
                              "Mirpur 1,Dhaka",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 12.0, top: 5),
                      child: Row(
                        children: [
                          Text(
                            "Phone: ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.new_color),
                          ),
                          Container(
                            width: 110,
                            child: Text(
                              "8801737907027",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }
                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: "ariful123@gmail.com",
                                    query:
                                    encodeQueryParameters(<String, String>{
                                      'subject':
                                      'Example Subject & Symbols are allowed!',
                                    }),
                                  );
                                  if (await canLaunchUrl(emailLaunchUri)) {
                                    launchUrl(emailLaunchUri);
                                  }
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: AppColors.new_color,
                                    ),
                                    Text("Email",style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                              ),

                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              final Uri call = Uri(
                                scheme: 'tel',
                                path: "8801737907027",);
                              if (await canLaunchUrl(call)) {
                                await launchUrl(call);
                              } else {
                                print("cant launch url");
                              }
                              ;
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ),
                                Text("call",style: TextStyle(fontSize: 10),)
                              ],
                            ),

                          ),
                          GestureDetector(
                              onTap: () async {
                                final Uri call = Uri(
                                  scheme:'sms',
                                  path: "8801737907027",);
                                if(await canLaunchUrl(call)){
                                  await launchUrl(call);
                                }else{
                                  print("cant launch url");
                                };

                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.sms,
                                    color: AppColors.new_color,
                                  ),
                                  Text("SMS",style: TextStyle(fontSize: 10),)
                                ],
                              )),
                          GestureDetector(
                              onTap: () async {
                                final Uri call = Uri(
                                  scheme:'sms',
                                  path: "8801737907027",);
                                if(await canLaunchUrl(call)){
                                  await launchUrl(call);
                                }else{
                                  print("cant launch url");
                                };

                              },
                              child: Column(
                                children: [
                                  FaIcon(FontAwesomeIcons.squareWhatsapp,color: Colors.green,),
                                  Text("WhatsApp",style: TextStyle(fontSize: 10),)
                                ],
                              )

                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Card(
              //   elevation: 10,
              //   child: Column(
              //     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       ListTile(
              //         onTap: () {
              //
              //         },
              //         leading: CircleAvatar(
              //           radius: 25,
              //           child: ClipRRect(
              //               borderRadius: BorderRadius.circular(25),
              //               child: Image.asset("images/avater 1.png",fit: BoxFit.cover,height: 100,
              //               )),
              //         ),
              //         title: Text("Md. Ariful Hasan",
              //           style: TextStyle(color: AppColors.new_color),
              //         ),
              //         subtitle: Text(
              //           "ariful123@gmail.com"
              //           // "Subject : ${snapshot.data!.docChanges[index].doc['subject']}"
              //         ),
              //       ),
              //
              //       Padding(
              //         padding:
              //         const EdgeInsets.only(left: 12.0, top: 5),
              //         child: Row(
              //           children: [
              //             Text(
              //               "Address: ",
              //               style: TextStyle(
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.bold,
              //                   color: AppColors.new_color),
              //             ),
              //             Container(
              //               width: 260,
              //               child: Text(
              //                 "Mirpur 1,Dhaka",
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ),
              //
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding:
              //         const EdgeInsets.only(left: 12.0, top: 5),
              //         child: Row(
              //           children: [
              //             Text(
              //               "Phone: ",
              //               style: TextStyle(
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.bold,
              //                   color: AppColors.new_color),
              //             ),
              //             Container(
              //               width: 110,
              //               child: Text(
              //                 "8801737907027",
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Row(
              //           mainAxisAlignment:
              //           MainAxisAlignment.spaceEvenly,
              //           children: [
              //             Column(
              //               children: [
              //                 GestureDetector(
              //                   onTap: () async {
              //                     String? encodeQueryParameters(
              //                         Map<String, String> params) {
              //                       return params.entries
              //                           .map((MapEntry<String, String> e) =>
              //                       '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              //                           .join('&');
              //                     }
              //                     final Uri emailLaunchUri = Uri(
              //                       scheme: 'mailto',
              //                       path: "ariful123@gmail.com",
              //                       query:
              //                       encodeQueryParameters(<String, String>{
              //                         'subject':
              //                         'Example Subject & Symbols are allowed!',
              //                       }),
              //                     );
              //                     if (await canLaunchUrl(emailLaunchUri)) {
              //                       launchUrl(emailLaunchUri);
              //                     }
              //                   },
              //                   child: Column(
              //                     children: [
              //                       Icon(
              //                         Icons.email,
              //                         color: AppColors.new_color,
              //                       ),
              //                       Text("Email",style: TextStyle(fontSize: 10),)
              //                     ],
              //                   ),
              //                 ),
              //
              //               ],
              //             ),
              //             GestureDetector(
              //               onTap: () async {
              //                 final Uri call = Uri(
              //                   scheme: 'tel',
              //                   path: "8801737907027",);
              //                 if (await canLaunchUrl(call)) {
              //                   await launchUrl(call);
              //                 } else {
              //                   print("cant launch url");
              //                 }
              //                 ;
              //               },
              //               child: Column(
              //                 children: [
              //                   Icon(
              //                     Icons.call,
              //                     color: Colors.green,
              //                   ),
              //                   Text("call",style: TextStyle(fontSize: 10),)
              //                 ],
              //               ),
              //
              //             ),
              //             GestureDetector(
              //                 onTap: () async {
              //                   final Uri call = Uri(
              //                     scheme:'sms',
              //                     path: "8801737907027",);
              //                   if(await canLaunchUrl(call)){
              //                     await launchUrl(call);
              //                   }else{
              //                     print("cant launch url");
              //                   };
              //
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Icon(
              //                       Icons.sms,
              //                       color: AppColors.new_color,
              //                     ),
              //                     Text("SMS",style: TextStyle(fontSize: 10),)
              //                   ],
              //                 )),
              //             GestureDetector(
              //                 onTap: () async {
              //                   final Uri call = Uri(
              //                     scheme:'sms',
              //                     path: "8801737907027",);
              //                   if(await canLaunchUrl(call)){
              //                     await launchUrl(call);
              //                   }else{
              //                     print("cant launch url");
              //                   };
              //
              //                 },
              //                 child: Column(
              //                   children: [
              //                     FaIcon(FontAwesomeIcons.squareWhatsapp,color: Colors.green,),
              //                     Text("WhatsApp",style: TextStyle(fontSize: 10),)
              //                   ],
              //                 )
              //
              //             ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // Card(
              //   elevation: 10,
              //   child: Column(
              //     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       ListTile(
              //         onTap: () {
              //
              //         },
              //         leading: CircleAvatar(
              //           radius: 25,
              //           child: ClipRRect(
              //               borderRadius: BorderRadius.circular(25),
              //               child: Image.asset("images/avater 1.png",fit: BoxFit.cover,height: 100,
              //               )),
              //         ),
              //         title: Text("Md. Ariful Hasan",
              //           style: TextStyle(color: AppColors.new_color),
              //         ),
              //         subtitle: Text(
              //           "ariful123@gmail.com"
              //           // "Subject : ${snapshot.data!.docChanges[index].doc['subject']}"
              //         ),
              //       ),
              //
              //       Padding(
              //         padding:
              //         const EdgeInsets.only(left: 12.0, top: 5),
              //         child: Row(
              //           children: [
              //             Text(
              //               "Address: ",
              //               style: TextStyle(
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.bold,
              //                   color: AppColors.new_color),
              //             ),
              //             Container(
              //               width: 260,
              //               child: Text(
              //                 "Mirpur 1,Dhaka",
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ),
              //
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding:
              //         const EdgeInsets.only(left: 12.0, top: 5),
              //         child: Row(
              //           children: [
              //             Text(
              //               "Phone: ",
              //               style: TextStyle(
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.bold,
              //                   color: AppColors.new_color),
              //             ),
              //             Container(
              //               width: 110,
              //               child: Text(
              //                 "8801737907027",
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Row(
              //           mainAxisAlignment:
              //           MainAxisAlignment.spaceEvenly,
              //           children: [
              //             Column(
              //               children: [
              //                 GestureDetector(
              //                   onTap: () async {
              //                     String? encodeQueryParameters(
              //                         Map<String, String> params) {
              //                       return params.entries
              //                           .map((MapEntry<String, String> e) =>
              //                       '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              //                           .join('&');
              //                     }
              //                     final Uri emailLaunchUri = Uri(
              //                       scheme: 'mailto',
              //                       path: "ariful123@gmail.com",
              //                       query:
              //                       encodeQueryParameters(<String, String>{
              //                         'subject':
              //                         'Example Subject & Symbols are allowed!',
              //                       }),
              //                     );
              //                     if (await canLaunchUrl(emailLaunchUri)) {
              //                       launchUrl(emailLaunchUri);
              //                     }
              //                   },
              //                   child: Column(
              //                     children: [
              //                       Icon(
              //                         Icons.email,
              //                         color: AppColors.new_color,
              //                       ),
              //                       Text("Email",style: TextStyle(fontSize: 10),)
              //                     ],
              //                   ),
              //                 ),
              //
              //               ],
              //             ),
              //             GestureDetector(
              //               onTap: () async {
              //                 final Uri call = Uri(
              //                   scheme: 'tel',
              //                   path: "8801737907027",);
              //                 if (await canLaunchUrl(call)) {
              //                   await launchUrl(call);
              //                 } else {
              //                   print("cant launch url");
              //                 }
              //                 ;
              //               },
              //               child: Column(
              //                 children: [
              //                   Icon(
              //                     Icons.call,
              //                     color: Colors.green,
              //                   ),
              //                   Text("call",style: TextStyle(fontSize: 10),)
              //                 ],
              //               ),
              //
              //             ),
              //             GestureDetector(
              //                 onTap: () async {
              //                   final Uri call = Uri(
              //                     scheme:'sms',
              //                     path: "8801737907027",);
              //                   if(await canLaunchUrl(call)){
              //                     await launchUrl(call);
              //                   }else{
              //                     print("cant launch url");
              //                   };
              //
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Icon(
              //                       Icons.sms,
              //                       color: AppColors.new_color,
              //                     ),
              //                     Text("SMS",style: TextStyle(fontSize: 10),)
              //                   ],
              //                 )),
              //             GestureDetector(
              //                 onTap: () async {
              //                   final Uri call = Uri(
              //                     scheme:'sms',
              //                     path: "8801737907027",);
              //                   if(await canLaunchUrl(call)){
              //                     await launchUrl(call);
              //                   }else{
              //                     print("cant launch url");
              //                   };
              //
              //                 },
              //                 child: Column(
              //                   children: [
              //                     FaIcon(FontAwesomeIcons.squareWhatsapp,color: Colors.green,),
              //                     Text("WhatsApp",style: TextStyle(fontSize: 10),)
              //                   ],
              //                 )
              //
              //             ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
