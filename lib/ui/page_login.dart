import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Roomazon/LocalBindings.dart';
import 'package:Roomazon/widgets/auth_design.dart';
import 'package:Roomazon/ui/page_forgotpass.dart';
import 'package:Roomazon/ui/page_home.dart';
import 'package:Roomazon/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'page_home.dart';
import 'page_signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Screen size;

  String _email;
  String _password;
  bool passwordVisible = true;
  final _formKey = new GlobalKey<FormState>();
  //toggle password
  void _togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  //validate and submit code
  bool validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (validateAndSave()) {
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Fluttertoast.showToast(msg: 'Log In Successful');
        //print("signed in  ${user.user.uid}");
        LocalStorage.sharedInstance
            .setAuthStatus(key: Constants.isLoggedIn, value: "true");
        Firestore.instance
            .collection('User')
            .where('uid', isEqualTo: user.user.uid)
            .snapshots()
            .listen((data) {
          print('Docfound :  ${data.documents[0].documentID}');
          LocalStorage.sharedInstance.setUserRef(
              key: Constants.userRef,
              value: data.documents[0].documentID.toString());
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SearchPage()));
      } catch (e) {
        print("error : $e");
        Fluttertoast.showToast(msg: e.code);
      }
    }
  }

  //Login with google

  void loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) print("Error while login with google  line : 83 ");
      AuthResult res = await FirebaseAuth.instance
          .signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if (res.user == null) print("Error While login with google line 90");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SearchPage()));
    } catch (e) {
      print("Error logging with google in catch line 91 $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.purple[700].withOpacity(1));
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipper2(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: size.hp(37),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x22673AB7), Color(0x22673AB7)])),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper3(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: size.hp(37),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x44673AB7), Color(0x44673AB7)])),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper1(),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.hp(4),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            child: Image.asset('assets/logo.jpg',
                                alignment: Alignment.center,
                                width: size.wp(30),
                                height: size.wp(30)),
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Text(
                          "Roomazon",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: size.hp(4)),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: size.hp(37),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff673AB7), Color(0xff673AB7)])),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.hp(2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.wp(6)),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  cursorColor: Colors.purple[900],
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.email,
                          color: Colors.purple[700],
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.wp(2.5), vertical: size.hp(2))),
                  validator: (value) =>
                      value.isEmpty ? "Email can't be empty" : null,
                  onSaved: (value) => _email = value,
                ),
              ),
            ),
            SizedBox(
              height: size.hp(2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.hp(3)),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  onSaved: (value) => _password = value,
                  obscureText: passwordVisible,
                  cursorColor: Colors.purple[800],
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.lock,
                          color: Colors.purple[700],
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.wp(2.5), vertical: size.hp(2))),
                  validator: (value) =>
                      value.isEmpty ? "Email can't be empty" : null,
                ),
              ),
            ),
            SizedBox(
              height: size.hp(3),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: size.wp(6)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(0xff673AB7)),
                  child: FlatButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: size.hp(3)),
                    ),
                    onPressed: validateAndSubmit,
                  ),
                )),
            SizedBox(
              height: size.hp(0.8),
            ),
            Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()));
                },
                child: Text(
                  "FORGOT PASSWORD ?",
                  style: TextStyle(
                      color: Colors.purple[700],
                      fontSize: size.hp(1.8),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: size.hp(2.6),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an Account ? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.hp(2),
                      fontWeight: FontWeight.normal),
                ),
                TextButton(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.purple[700],
                        fontWeight: FontWeight.w500,
                        fontSize: size.hp(2),
                        decoration: TextDecoration.underline),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
