import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/LoginPage.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

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
        title: Text("About",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22)),
        centerTitle: true,
        backgroundColor: AppColors.new_color,
        actions: [
          PopupMenuButton<int>(
            // color: Colors.black,
              onSelected: (item) => onSelected(context, item),
              //color: Colors.black,
              itemBuilder: (context) =>
              [
                // PopupMenuItem(value: 0,
                //   child: Text("Search",)),
                PopupMenuItem(value: 1,
                    child: Text("Log Out",)),

              ]),

        ],
      ),
      body: Container(
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: ScrollPhysics(),
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    "images/avater 1.png",
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 80,
                  width: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.new_color),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Md. Ariful Hasan",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22)),
                      Text("Android Developer",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18))
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.new_color),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                    "Welcome to my world of creativity and innovation! I'm Md. Ariful Hasan,                  "
                    "     I take great pride in earning my Bachelor of Science degree from Daffodil International University."
                    " My academic journey provided me with a solid foundation in computer science and programming principles,"
                    " which have been invaluable in my career as an Android developer. The learnings and experiences"
                    " from my time at university have shaped me into the professional I am today."),
              ),
              Text(
                "About Tuition Finder Application  : ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.new_color),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Text(
                      "A Platform for Passionate Educators : ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text("For tutors, "
                        "My Tuition Finder opens doors to a world of opportunities. "
                        "As a tutor on our platform, you can showcase your expertise, share your passion for teaching, "
                        "and make a meaningful impact on the lives of students. Our user-friendly interface allows you to manage"
                        " your schedule, communicate with students, and receive secure payments hassle-free. Whether you're a "
                        "seasoned educator or a talented student eager to share"
                        " your knowledge, we welcome you to join our community of dedicated tutors."),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.new_color),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Text(
                      "Join the My Tuition Finder Family : ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text("Whether you're a student or a tutor, My Tuition Finder invites you to be a part of"
                        " our family. Together, let's embark on a journey of discovery, learning, and growth."
                        " Download our app today and take the first step towards a brighter, more empowered "
                        "future.Remember, with My Tuition Finder, learning knows no bounds!"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.new_color),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Text(
                      "Personalized Learning Experience : ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "We believe in the power of personalized education. Each student is different, and our app enables "
                        "tutors to tailor their teaching methods to match individual learning styles. Through one-on-one "
                        "sessions, students receive undivided attention, targeted guidance, and encouragement to excel "
                        "academically. Our aim is to foster a love for learning and create a "
                        "positive, supportive environment that helps students thrive."),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.new_color),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Text(
                      "Building a Community of Lifelong Learners : ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "My Tuition Finder is more than just an app; it's a vibrant community of "
                            "lifelong learners. We encourage students to embrace curiosity, ask questions, "
                            "and pursue knowledge beyond the classroom. Our tutors are not just teachers; they "
                            "are mentors who inspire a thirst for knowledge and nurture a growth mindset in "
                            "their students"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
