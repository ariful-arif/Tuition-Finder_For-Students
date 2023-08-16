import 'dart:developer';
import 'dart:io';

import 'package:diu_project1/models/UIHelper.dart';
import 'package:diu_project1/models/UserModel.dart';
import 'package:diu_project1/pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_project1/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../lib3/const/app_color.dart';
import 'LoginPage.dart';

class CompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfile(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  File? imageFile;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  List<String> gender = ["Male", "Female", "Others"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('d MMMM, y').format(picked);
        dobController.text = formattedDate;
      });
    }
  }

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    // imageFile = pickedFile;
    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 50);

    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Upload Profile Picture",style: TextStyle(color: AppColors.new_color),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 10,
                  color: AppColors.new_color,
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.gallery);
                    },
                    leading: Icon(Icons.photo_album,color: Colors.black,),
                    title: Text("Select from Gallery"),
                  ),
                ),
                Card(
                  elevation: 10,
                  color: AppColors.new_color,
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.camera);
                    },
                    leading: Icon(Icons.camera_alt,color: Colors.black,),
                    title: Text("Take a photo"),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void checkValues() {
    String fullname = fullNameController.text.trim();

    if (fullname == "" || imageFile == null) {
      print("Please fill all the fields");
      UIHelper.showAlertDialog(context, "Incomplete Data",
          "Please fill all the fields and upload a profile picture");
    } else {
      log("Uploading data..");
      uploadData();
    }
  }

  void uploadData() async {
    UIHelper.showLoadingDialog(context, "Uploading image..");

    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilepictures")
        .child(widget.userModel.email.toString())
        .putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    String? imageUrl = await snapshot.ref.getDownloadURL();
    String? fullname = fullNameController.text.trim();
    String? gender = genderController.text.trim();
    String? phone = phoneController.text.trim();
    String? dob = dobController.text.trim();
    String? age = ageController.text.trim();

    widget.userModel.fullname = fullname;
    widget.userModel.profilepic = imageUrl;
    widget.userModel.gender = gender;
    widget.userModel.phone = phone;
    widget.userModel.dob = dob;
    widget.userModel.age = age;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) {
      log("Data uploaded!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return LoginPage(
              // userModel: widget.userModel, firebaseUser: widget.firebaseUser
              );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   title: Text("Complete Profile"),
      // ),
      body: Container(
        color: AppColors.new_color,
        child: ListView(children: [
          Container(
            //margin: EdgeInsets.only(top: 20),
            color: AppColors.new_color,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child:  Padding(
              padding: const EdgeInsets.only(top: 88.0),
              child: Text(
                "Tuition Finder",
                style: TextStyle(
                    color: Colors.blue[50],
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                ),textAlign: TextAlign.center,
              ),
            ),

          ),
          Container(
            color: AppColors.new_color,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              // padding: EdgeInsets.symmetric(
              //   horizontal: 40,
              // ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                        children: [
                          CircleAvatar(
                            radius:63,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.new_color,
                              backgroundImage: (imageFile!= null)
                                  ? FileImage(imageFile!):null,
                              //backgroundColor: Colors.blueGrey,
                              child: (imageFile == null) ? Icon(Icons.person,size: 60,color: Colors.white,): null,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 85.0,left: 90),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {
                                    showPhotoOptions();
                                  },
                                  // onPressed: ()async{
                                  //   XFile? selectedImage= await ImagePicker().pickImage(source:
                                  //   ImageSource.gallery);
                                  //   if(selectedImage != null){
                                  //     cropImage(selectedImage);
                                  //   }
                                  // },
                                  icon: Icon(Icons.camera_enhance_sharp,size: 20,color: Colors.black,),)),
                          ),
                        ]
                    ),
                    // CupertinoButton(
                    //   onPressed: () {
                    //     showPhotoOptions();
                    //   },
                    //   padding: EdgeInsets.all(0),
                    //   child: CircleAvatar(
                    //     radius: 60,
                    //     backgroundImage:
                    //         (imageFile != null) ? FileImage(imageFile!) : null,
                    //     child: (imageFile == null)
                    //         ? Icon(
                    //             Icons.person,
                    //             size: 60,
                    //           )
                    //         : null,
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      enabled: true,
                      controller: fullNameController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor: AppColors.new_color,
                        prefixIcon: Icon(Icons.edit_note_sharp),
                        label: Text("Full Name"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.new_color,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.new_color),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: true,
                      controller: phoneController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor: AppColors.new_color,
                        prefixIcon: Icon(Icons.phone),
                        label: Text("Phone"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.new_color,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.new_color),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: true,
                      controller: genderController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor: AppColors.new_color,
                        prefixIcon: Icon(Icons.transgender),
                        label: Text("Gender"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.new_color,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.new_color),
                        ),

                        suffixIcon: DropdownButton<String>(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(Icons.arrow_drop_down_circle_outlined,color: AppColors.new_color,),
                          ),
                          items: gender.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                              onTap: () {
                                setState(
                                      () {
                                    genderController.text = value;
                                  },
                                );
                              },
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: true,
                      controller: ageController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor: AppColors.new_color,
                        prefixIcon: Icon(Icons.calendar_today_sharp),
                        label: Text("Age"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.new_color,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.new_color),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: true,
                      readOnly: true,
                      controller:dobController ,
                      //obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor: AppColors.new_color,
                        prefixIcon: Icon(Icons.calendar_month_sharp),
                        label: Text("Date of Birth"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.new_color,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.new_color),
                        ),
                          suffixIcon: IconButton(
                              onPressed: () => _selectDateFromPicker(context),
                              icon: Icon(Icons.calendar_month_sharp,color: AppColors.new_color,))
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkValues();
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(270, 50),
                          backgroundColor: AppColors.new_color,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)))),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
