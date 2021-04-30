import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Roomazon/ui/page_home.dart';
import 'package:Roomazon/ui/page_login.dart';
import 'package:Roomazon/ui/page_signup.dart';
import 'package:Roomazon/utils/responsive_screen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class FirstScreen extends StatelessWidget {
  Screen size;
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          TextButton.icon(
            label: Text(
              'Skip',
              style: TextStyle(
                fontSize: size.getWidthPx(16),
                fontWeight: FontWeight.normal,
                color: Color(0xff673AB7),
              ),
            ),
            icon: Icon(
              Icons.close,
              color: Color(0xff673AB7),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: size.hp(7)),
                    child: Text('Best way to Find a Home or',
                        style: new TextStyle(
                          fontSize: size.getWidthPx(20),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff673AB7),
                        ))),
                Padding(
                  padding: EdgeInsets.only(bottom: size.hp(2)),
                  child: Text(
                    'Someone to Share your Home With',
                    style: new TextStyle(
                      fontSize: size.getWidthPx(20),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff673AB7),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.hp(5),
                ),
                Image.asset(
                  'assets/landing_page.png',
                  width: size.wp(100),
                ),
                SizedBox(
                  height: size.hp(5),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.getWidthPx(10)),
                  child: RaisedButton(
                    child: Text('CREATE FREE ACCOUNT'),
                    color: Colors.purple[700],
                    textColor: Colors.white,
                    elevation: 5,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(10),
                        horizontal: size.getWidthPx(24)),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, size.getWidthPx(5), 0, size.hp(6.5)),
                  child: RaisedButton(
                    child: Text('SIGN IN'),
                    color: Colors.white,
                    textColor: Colors.purple[700],
                    elevation: 5,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(8),
                        horizontal: size.getWidthPx(70)),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                ),
                SizedBox(
                  height: size.hp(5),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
