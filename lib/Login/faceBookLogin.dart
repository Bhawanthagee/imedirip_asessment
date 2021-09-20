import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:imedirip_asessment/pages/homePage.dart';

import '../constants.dart';

class FaceBookLogin extends StatefulWidget {
  const FaceBookLogin({Key? key}) : super(key: key);

  @override
  _FaceBookLoginState createState() => _FaceBookLoginState();
}

class _FaceBookLoginState extends State<FaceBookLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb2f3f7),
      body: Column(
        children: [
          Expanded(
            flex: 2,
              child: Container(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                )
              )
          ),
          Expanded(
              flex: 4,
              child: Container(
                decoration: buildBoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.only(top:38.0),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.stretch,
                    children: [
                      Center(child: Text("LoginWith",style: TextStyle(fontSize: 20),)),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,right: 30,left: 30),
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              color: Colors.blue
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                            GestureDetector(
                              child: Container(
                                height: 50,
                                child: Image(
                                  image: AssetImage( 'assets/images/fb.png'),
                                ),
                              ),
                              onTap:(){
                                _loginWithFaceBook();
                              },
                            ),

                                SocialMediaButton(//google
                                  path: 'assets/images/goo.png',
                                  onPressed: (){

                                  },
                                ),
                                SocialMediaButton(//linked in
                                  path: 'assets/images/link.png',
                                  onPressed: (){

                                  },
                                ),
                                SocialMediaButton(//reddit
                                  path: 'assets/images/reddit.png',
                                  onPressed: (){

                                  },
                                ),
                                SocialMediaButton(//email
                                  path: 'assets/images/email.png',
                                  onPressed: (){

                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(child: Text("Or")),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                        child: Divider(
                          height: 10,
                          thickness: 3,
                          color: Colors.black38,
                        ),
                      ),
                      Center(child: Text("Sign in"),),
                      Padding(
                        padding: const EdgeInsets.only(left:28.0,right: 28,top: 20),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          height: 60.0,
                          child: TextFormField(
                            onChanged: (value) {

                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return " Email can not be empty";
                              }
                            },

                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your Email',
                              hintStyle: kHintTextStyle,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:28.0,right: 28,top: 20),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          height: 60.0,
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (value) {

                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return " Password can not be empty";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your Password',

                              hintStyle: kHintTextStyle,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:28.0,right: 28,top: 20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {



                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.lightBlueAccent,
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
  var loading = false;
  void _loginWithFaceBook()async {
    print('hellow');
    setState(() {
      loading = true;
    });
    try{
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential= FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      await FirebaseFirestore.instance.collection('users').add({
        'email': userData['email'],
        'imageURL': userData['picture']['data']['url'],
        'name': userData['name'],
      });
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>HomePage()), (route) => false);

    }
    on FirebaseAuthException catch (e){
      var content='';
      switch(e.code){
        case 'account-exists-with-different-credential':
          content='This account exist with another sign in provider';
          break;
        case 'invalid-credential' :
          content = "invalid credentials";
          break;
        case 'operation-not-allowed':
          content = "this opperation is not allowed";
          break;
        case 'user-disabled':
          content = "This user you try to log in to is disabled";
          break;
        case 'user-not-found':
          content = "This user you try to log in to is not found";
          break;
      }
     showDialog(context: context, builder: (context)=>AlertDialog(
       title: Text("Log in with facebook failed"),
       content: Text(content),
       actions: [TextButton(onPressed: (){
         Navigator.of(context).pop();
       }, child: Text("Ok"))],
     ));

    }finally{
      setState(() {
        loading=false;
      });
    }

  }






}

class SocialMediaButton extends StatelessWidget {
  final String path;
  final Function onPressed;

  const SocialMediaButton({
    Key? key, required this.path, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        child: Image(
          image: AssetImage(path),
        ),
      ),
      onTap:onPressed(),
    );
  }
}


//methods :)

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      )
  );
}
