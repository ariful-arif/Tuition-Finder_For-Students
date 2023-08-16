import 'package:diu_project1/lib3/const/app_color.dart';
import 'package:flutter/material.dart';

class UIHelper {

  static void showLoadingDialog(BuildContext context, String title) {
    AlertDialog loadingDialog = AlertDialog(
      content: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            CircularProgressIndicator(),

            SizedBox(height: 30,),

            Text(title),

          ],
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loadingDialog;
      }
    );
  }


  static void showAlertDialog(BuildContext context, String title, String content) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title,style: TextStyle(color: AppColors.new_color),),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok",style: TextStyle(color: AppColors.new_color),),
        ),
      ],
    );

    showDialog(context: context, builder: (context) {
      return alertDialog;
    });
  }

}