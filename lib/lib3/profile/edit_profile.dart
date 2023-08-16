import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/UserModel.dart';
import '../const/app_color.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  EditProfile({required this.userModel, required this.firebaseUser});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController? _nameController;
  //TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  setDataToTextField(data) {
    return ListView(
      children: [
        TextField(
          enabled: true,
          controller: _nameController =
              TextEditingController(text: data['fullname']),
          //obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: AppColors.new_color,
            prefixIcon: Icon(Icons.edit),
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

        const SizedBox(height: 15),

        // const SizedBox(height: 15),
        TextField(
          enabled: true,
          controller: phoneController =
              TextEditingController(text: data['phone']),
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

        const SizedBox(height: 15),
        TextField(
          enabled: true,
          controller: genderController =
              TextEditingController(text: data['gender']),
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
          ),
        ),

        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () => updateData(),
          child: Text("Update"),
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.new_color,
              minimumSize: Size(300, 50),
              //primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        ),
      ],
    );
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "fullname": _nameController!.text,
      "phone": phoneController!.text,
      //"email": emailController!.text,
      "gender": genderController!.text,
    }).then(
      (value) => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.new_color,
        title: Text("Edit Profile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
      ),
      body: SafeArea(
          child: Container(
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var data = snapshot.data;

                if (data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return setDataToTextField(data);
              }),
        ),
      )),
    );
  }
}
