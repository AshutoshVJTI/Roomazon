import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Roomazon/ui/page_home.dart';
import 'package:Roomazon/ui/page_login.dart';
import 'package:Roomazon/utils/utils.dart';
import 'package:Roomazon/widgets/auth_design.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:Roomazon/LocalBindings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _phoneNo;
  String _fname;
  String _lname;
  String _confirmPassword;
  String _uid;
  Screen size;
  String city;

  final DocumentReference documentReference =
      Firestore.instance.collection("User").document();

  // adding data to fire store

  void _add() {
    Map<String, dynamic> data = <String, dynamic>{
      "firstName": _fname,
      "lastName": _lname,
      "city": city,
      "mobileNo": _phoneNo,
      "email": _email,
      "uid": _uid,
      "status": true,
      "Date Created": DateTime.now(),
    };
    documentReference.setData(data).whenComplete(() {
      print("Data added");
    }).catchError((e) => print(e));
  }

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
            .createUserWithEmailAndPassword(email: _email, password: _password);
        print("signed in  ${user.user.uid}");
        _uid = user.user.uid;
        try {
          LocalStorage.sharedInstance
              .setAuthStatus(key: Constants.isLoggedIn, value: "true");
        } catch (e) {
          print("An error occurred while trying to send email verification");
        }
        _add();
        Firestore.instance
            .collection('User')
            .where('uid', isEqualTo: _uid)
            .snapshots()
            .listen((data) {
          print('Docfound :  ${data.documents[0].documentID}');
          LocalStorage.sharedInstance.setUserRef(
              key: Constants.userRef, value: data.documents[0].documentID);
        });
        Fluttertoast.showToast(msg: "Account Registered Successfully");
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
        //print("error : $e");
        Fluttertoast.showToast(msg: e.code);
      }
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
                    height: size.hp(20),
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
                    height: size.hp(20),
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
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(top: size.getWidthPx(10)),
                            child: Text(
                              "Roomazon",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.getWidthPx(30)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: size.hp(20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff673AB7), Color(0xff673AB7)])),
                  ),
                ),
                Positioned(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                    },
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
                      hintText: "First Name",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.person,
                          color: Colors.purple[700],
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.wp(2.5), vertical: size.hp(2))),
                  validator: (value) =>
                      value.isEmpty ? "First Name can't be empty" : null,
                  onSaved: (value) => _fname = value,
                ),
              ),
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
                      hintText: "Last Name",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.person,
                          color: Colors.purple[700],
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.wp(2.5), vertical: size.hp(2))),
                  validator: (value) =>
                      value.isEmpty ? "Last Name can't be empty" : null,
                  onSaved: (value) => _lname = value,
                ),
              ),
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
                      hintText: "City",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.anchor,
                          color: Colors.purple[700],
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.wp(2.5), vertical: size.hp(2))),
                  validator: (value) =>
                      value.isEmpty ? "City Name can't be empty" : null,
                  onSaved: (value) => city = value,
                ),
              ),
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
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.purple[900],
                  decoration: InputDecoration(
                      hintText: "Mobile Number",
                      prefixText: "+91",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.phone_android,
                          color: Colors.purple[700],
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.wp(2.5), vertical: size.hp(2))),
                  validator: (value) =>
                      value.isEmpty ? "Mobile Number can't be empty" : null,
                  onSaved: (value) => _phoneNo = "+91" + value,
                ),
              ),
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
                  keyboardType: TextInputType.emailAddress,
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
                  obscureText: true,
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
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.wp(2.5), vertical: size.hp(2))),
                  validator: (value) =>
                      value.isEmpty ? "Password can't be empty" : null,
                  onSaved: (value) => _password = value,
                ),
              ),
            ),
            SizedBox(
              height: size.hp(3),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.hp(3)),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  obscureText: true,
                  cursorColor: Colors.purple[800],
                  decoration: InputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.lock,
                          color: Colors.purple[700],
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.wp(2.5), vertical: size.hp(2))),
                  validator: (value) =>
                      value.isEmpty ? "Confirm Password can't be empty" : null,
                  onSaved: (value) => _password = value,
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
                      "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: size.hp(3)),
                    ),
                    onPressed: validateAndSubmit,
                  ),
                )),
            SizedBox(
              height: size.hp(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already Registered ? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.hp(2),
                      fontWeight: FontWeight.normal),
                ),
                FlatButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.purple[700],
                        fontWeight: FontWeight.w500,
                        fontSize: size.hp(2),
                        decoration: TextDecoration.underline),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
