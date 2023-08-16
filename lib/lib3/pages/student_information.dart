import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_project1/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../models/UIHelper.dart';
import '../../models/UserModel.dart';
import '../const/app_color.dart';

class StudentInformation extends StatefulWidget {
  static const String routeName = '/studentInformation';
  final UserModel userModel;
  final User firebaseUser;

  const StudentInformation(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<StudentInformation> createState() => _StudentInformationState();
}

class _StudentInformationState extends State<StudentInformation> {
  File? profilepic;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController curriculumController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  List<String> gender = ["Male", "Female", "All"];
  List<String> curriculum = ["Banglai-Medium", "English-Medium", "Others"];
  List<String> day = [
    "1 day",
    "2 days",
    "3 days",
    "4 days",
    "5 days",
    "6 days",
    "7 days"
  ];

  // Future<void> _selectDateFromPicker(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(DateTime.now().year - 70),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       dobController.text = "${picked.day} - ${picked.month} - ${picked.year}";
  //     });
  //   }
  // }
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


  void cropImage(XFile file) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 50);

    if (croppedImage != null) {
      setState(() {
        profilepic = croppedImage;
      });
    }
  }
  void checkValues() {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (profilepic == null) {
        UIHelper.showAlertDialog(context, "Incomplete Data",
            "Please upload a profile picture");
      } else {
        log("Uploading data..");
        sendUserDataToDB();
      }
    }
  }
  sendUserDataToDB() async {
    UIHelper.showLoadingDialog(context, "Uploading image..,Uploading Data");
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;

    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("student_profile")
        .child(const Uuid().v1())
        .putFile(profilepic!);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadurl = await taskSnapshot.ref.getDownloadURL();

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("students");
    return collectionRef
        .doc(currentUser!.email)
        .set({
          "profileStu": downloadurl,
          "title": titleController.text,
          "name": nameController.text,
          "address": addressController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "dob": dobController.text,
          "gender": genderController.text,
          "days": daysController.text,
          "class": classController.text,
          "curriculum": curriculumController.text,
          "subject": subjectController.text,
          "salary": salaryController.text,
          "date": DateTime.now(),
        })
        .then(
          (value) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomePage(
                userModel: widget.userModel,
                firebaseUser: widget.firebaseUser,
              )));
    })
        .catchError(
            (error) => Fluttertoast.showToast(msg: "something is wrong."));
  }



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColors.new_color,
          title: const Text(
            "Tutor Request",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
          ),
          // backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, top: 15, right: 25, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Stack(children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 52,
                              backgroundColor: AppColors.new_color,
                              backgroundImage: (profilepic != null)
                                  ? FileImage(profilepic!)
                                  : null,
                              //backgroundColor: Colors.blueGrey,
                              child: (profilepic == null)
                                  ? const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 70.0, left: 75),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: IconButton(
                                  onPressed: () async {
                                    XFile? selectedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (selectedImage != null) {
                                      cropImage(selectedImage);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.camera_enhance_sharp,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                        ]),
                      ),
                      const Text(
                        "Title:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        minLines: 2,
                        maxLength: 250,
                        maxLines: 7,
                        enabled: true,
                        controller: titleController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: AppColors.new_color,
                          prefixIcon: const Icon(Icons.title_rounded),
                          hintText: "Need a Tutor from DIU or DU etc...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                        ),
                      ),
                      StreamBuilder<Object>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Name:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black45),
                                ),
                                TextField(
                                  enabled: true,
                                  controller: nameController =
                                      TextEditingController(
                                          text: snapshot.data['fullname']),
                                  //obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIconColor: AppColors.new_color,
                                    prefixIcon: const Icon(
                                        Icons.drive_file_rename_outline),
                                    //hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.new_color,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: AppColors.new_color),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Email:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black45),
                                ),
                                TextField(
                                  enabled: true,
                                  controller: emailController =
                                      TextEditingController(
                                          text: snapshot.data['email']),
                                  //obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIconColor: AppColors.new_color,
                                    prefixIcon: const Icon(Icons.email_outlined),
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.new_color,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: AppColors.new_color),
                                    ),
                                  ),
                                ),
                                // TextField(
                                //   readOnly: true,
                                //   controller: emailController = TextEditingController(
                                //       text: snapshot.data['email']),
                                //   decoration: InputDecoration(
                                //       filled: true,
                                //       fillColor: Colors.blue[50],
                                //       hintText: "Email",
                                //       border: OutlineInputBorder()),
                                // ),
                              ],
                            );
                          }),
                      const SizedBox(height: 8),
                      const Text(
                        "Subjects:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        enabled: true,
                        controller: subjectController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: AppColors.new_color,
                          prefixIcon: const Icon(Icons.book),
                          hintText: "Bangla, English, Math etc..",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Class:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        enabled: true,
                        controller: classController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          //prefixIconColor: AppColors.new_color,
                          //prefixIcon: Icon(Icons.email_outlined),
                          hintText: "Eight, Nine..",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Curriculum:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        readOnly: true,
                        enabled: true,
                        controller: curriculumController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: Colors.grey,
                          //prefixIcon: Icon(Icons.email_outlined),
                          hintText: "Select Medium",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                          suffixIconColor: AppColors.new_color,
                          suffixIcon: DropdownButton<String>(
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: AppColors.new_color,
                              ),
                            ),
                            items: curriculum.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  setState(
                                    () {
                                      curriculumController.text = value;
                                    },
                                  );
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Tutor Gender:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        readOnly: true,
                        enabled: true,
                        controller: genderController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Gender",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                          suffixIcon: DropdownButton<String>(
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: AppColors.new_color,
                              ),
                            ),
                            items: gender.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
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
                      const SizedBox(height: 8),
                      const Text(
                        "Days/Week:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        readOnly: true,
                        enabled: true,
                        controller: daysController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          //prefixIconColor: Colors.grey,
                          //prefixIcon: Icon(Icons.email_outlined),
                          hintText: "Select one",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                          suffixIcon: DropdownButton<String>(
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: AppColors.new_color,
                              ),
                            ),
                            items: day.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  setState(
                                    () {
                                      daysController.text = value;
                                    },
                                  );
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Date of Birth:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        readOnly: true,
                        enabled: true,
                        controller: dobController,
                        //obscureText: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //prefixIconColor: Colors.grey,
                            //prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Select Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: AppColors.new_color,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: AppColors.new_color),
                            ),
                            suffixIconColor: AppColors.new_color,
                            suffixIcon: IconButton(
                                onPressed: () => _selectDateFromPicker(context),
                                icon: const Icon(Icons.calendar_month_sharp))),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Phone number:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        enabled: true,
                        controller: phoneController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: AppColors.new_color,
                          prefixIcon: const Icon(Icons.call),
                          hintText: "01xxxxxxxxx",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Select location:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        enabled: true,
                        controller: addressController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: AppColors.new_color,
                          prefixIcon: const Icon(Icons.add_location_alt_rounded),
                          hintText: "Mirpur, Dhanmondi etc..",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Salary:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        enabled: true,
                        controller: salaryController,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: AppColors.new_color,
                          prefixIcon: const Icon(Icons.money),
                          hintText: "5000,6000 or negotiable",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.new_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.new_color),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          checkValues();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(500, 50),
                            backgroundColor: AppColors.new_color,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      // CupertinoButton(
                      //     color: AppColors.new_color,
                      //     child: Text("save"),
                      //     onPressed: () {
                      //       sendUserDataToDB();
                      //       //saveUser();
                      //     }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
// void saveUser() {
//   String name = nameController.text.trim();
//   String address = addressController.text.trim();
//
//   nameController.clear();
//   addressController.clear();
//
//   if (name != "" && address != "") {
//     Map<String, dynamic> userData = {"name": name, "address": address};
//     FirebaseFirestore.instance.collection("students").add(userData);
//     log("User created");
//   } else {
//     log("Please fill all the details");
//   }
// }
