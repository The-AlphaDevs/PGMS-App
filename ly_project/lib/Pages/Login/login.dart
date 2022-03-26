import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Services/AuthServices.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/Widgets/CurveClipper.dart';
import 'package:ly_project/root_page.dart';
import 'package:ly_project/utils/colors.dart';
import 'package:ly_project/utils/constants.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  LoginPage({@required this.auth});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF181D3D),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      color: Color(0xFF181D3D),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 16),
                          Text(
                            'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .apply(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 80),
                            TextFormField(
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'Email cannot be left Empty';
                                }
                                RegExp regExp = new RegExp(EMAIL_REGEX);
                                if (!regExp.hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Password cannot be left Empty';
                                return null;
                              },
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: 40),
                            SizedBox(
                              height: 45,
                              child: RaisedButton(
                                onPressed: () async {
                                  if (validateAndSave()) {
                                    _showDialog(context);

                                    AuthServices.loginSupervisor(
                                      email: _emailController.text
                                          .toString()
                                          .trim()
                                          .toLowerCase(),
                                      password: _passwordController.text
                                          .toString()
                                          .trim(),
                                      errorCallback: (message) {
                                        Navigator.pop(context);
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.ERROR,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: "Error",
                                          desc: message,
                                          btnOkOnPress: () {},
                                        )..show();
                                      },
                                      successCallback: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => RootPage(
                                                    auth: widget.auth)));
                                      },
                                    );
                                  } else {
                                    print("Failure in saving the form");
                                  }
                                },
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                highlightElevation: 5,
                                color: Color(0xFF181D3D),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(DARK_PURPLE),
          ),
          Container(
            margin: EdgeInsets.only(left: 7),
            child: Text("Signing In..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // Doesn't allow the dialog box to pop
        return WillPopScope(
            onWillPop: () {
              return;
            },
            child: alert);
      },
    );
  }

  showErrorDialog(BuildContext context, String title, String content) {
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(color: Colors.blue)),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool validateAndSave() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      return true;
    } else {
      return false;
    }
  }
}
