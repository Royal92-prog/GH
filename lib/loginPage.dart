import 'dart:ffi';

import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_me2/classesManagement.dart';
import 'package:hello_me2/AuthenticationService.dart';


class logInPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _savedWords;

  logInPage(this._savedWords);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:MyCustomForm(_savedWords),);
  }
}


class MyCustomForm extends StatefulWidget {
  //const MyCustomForm({Key? key}) : super(key: key);

  var _savedWords;
  MyCustomForm(this._savedWords);

  @override
  _MyCustomFormState createState() => _MyCustomFormState(this._savedWords);
}


// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final email = TextEditingController();
  final password = TextEditingController();
  bool alreadyPressed = false;
  int counter = 0;
  var _savedWords;

  _MyCustomFormState(this._savedWords);

  @override
  void initState() {
    this.alreadyPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    // print(this._savedWords);
    return Scaffold(
      body:Column(

        children:[SizedBox( height: 20.0, ),
          //define email & passwords fields
         Text("Welcome to startup Names Generator, please log in \n below",
         style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.w400),),

          SizedBox( height: 15.0, ),
          TextFormField(
            controller: email,
            cursorColor: Colors.deepPurple,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2.0),
                    topRight: Radius.circular(2.0),
                  ),
                  borderSide: BorderSide(width:0.5,style: BorderStyle.solid),),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.solid),),
                contentPadding: EdgeInsets.zero,
                border: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid)),
                labelText:'  Email',
                labelStyle: TextStyle(
                 color: Colors.black,)
          ),),
          SizedBox( height: 15.0, ),

          TextFormField(
            controller: password,
            cursorColor: Colors.deepPurple,
            obscureText: true,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),),
              border: OutlineInputBorder(),//UnderlineInputBorder(),
              labelText: 'Password',contentPadding: EdgeInsets.zero,
              labelStyle: TextStyle(
                color: Colors.deepPurple,),),),
          SizedBox( height: 15.0, ),

          ButtonTheme(
            child: SizedBox(
              width: 270,
              height: 30,
              child:ElevatedButton(
              onPressed: alreadyPressed ? null :() async {
                print(alreadyPressed);
                setState(() {
                  alreadyPressed = true;
                });
                print("kalabasa");
                await Future.delayed(const Duration(seconds: 3));
                print("kalab");
                counter++;
                print(counter);
                alreadyPressed = true;
                //print(email.text.trim());
                //print("line 101");
                User? _user = await context.read<AuthenticationService>().signIn(savedWords: _savedWords, email: email.text.trim(), password: password.text.trim(),);
                //print("line 102");
                //if (!res)print("errr");
                if (_user != null) { //transferring correctly

                  Navigator.pop(context, email.text.trim());
                }

                else {
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('There was an error logging into the app'),));

                  });
                }
                setState(() {
                  alreadyPressed = false;
                });
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // background
                onPrimary: Colors.white, // foreground
              ),),),
            //minWidth: 290.0,
            //height: 20.0,
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          ),],), );}


}