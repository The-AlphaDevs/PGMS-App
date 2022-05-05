import 'package:flutter/material.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/navigation.dart';
import 'package:ly_project/Widgets/CurveClipper.dart';

import '../../root_page.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  // final VoidCallback onsignedIn;
  LoginPage({this.auth});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   user = FirebaseAuth.instance.currentUser;
  //   _nameController.text = user.displayName;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF181D3D),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: ListView(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      color: Color(0xFF181D3D),
                      child: Column(children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 16),
                        Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .apply(color: Colors.white),
                        )
                      ]),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Email cannot be left Empty';
                              }
                              return null;
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password cannot be left Empty';
                              }
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
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 45,
                            child: RaisedButton(
                              onPressed: () async {
                                if (validateAndSave()) {
                                  // Scaffold.of(context).showSnackBar(SnackBar(
                                  //   content:
                                  //     Text('Establishing Contact with the Server')));
                                  _showDialog(context);
                                  String useruid =
                                      await mixtureofcalls(context);
                                  print("apna Userid: " + useruid);
                                  if (useruid != "User doesn't Exist!!" &&
                                      useruid != "Error in Validation!!") {
                                    print("andar aaya");
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => BottomNavBar(
                                    //             auth: widget.auth)));

                                    Navigator.push(context , MaterialPageRoute(builder: (context) => RootPage(auth :widget.auth)));
                                  }
                                  // else
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
            ]),
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
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF181D3D)),
          ),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("  Signing In...")),
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
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.pop(context, null);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
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

  Future<String> mixtureofcalls(BuildContext context) async {
    print("mixtureofcalls Function Call!!!!!!!!!!!!!!!!!");
    try {
      print("Email: ");
      print(_emailController.text.toString());
      print(_passwordController.text.toString());
      String user = await widget.auth.signInWithEmailAndPassword(
          _emailController.text.toString(),
          _passwordController.text.toString());

      print("Logged In user => " + user);
      return user;
    } catch (e) {
      print("Error => $e");
      print("Email: " +
          _emailController.text.toString() +
          " Password: " +
          _passwordController.text.toString());
      Navigator.pop(context);
      showErrorDialog(context, "SignIn Error",
          "Please enter the correct email and password.");
      return "User doesn't Exist!!";
    }
  }
}
