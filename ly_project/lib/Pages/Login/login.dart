import 'package:flutter/material.dart';
import 'package:ly_project/navigation.dart';
import 'package:ly_project/Widgets/CurveClipper.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    SizedBox(height: MediaQuery.of(context).size.height / 16),
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
          RegisterForm()
        ]))),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String hostelname;
  final _nameController = TextEditingController();
  final _rollNoController = TextEditingController();
  final _roomNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // User user;

  // @override
  // void initState() {
  //   super.initState();
  //   user = FirebaseAuth.instance.currentUser;
  //   _nameController.text = user.displayName;
  // }

  void formProcessor() async {
    /*
      Add the document of the UserDetails to the usercollection class
      For model reference, check models.dart
    */
    // final database = FirebaseFirestore.instance.collection('users');
    // await database.doc('${user.uid}').set({
    //   'name': _nameController.text,
    //   'uid': user.uid,
    //   'email': user.email,
    //   'hostel': hostelname,
    //   'rollNo': int.parse(_rollNoController.text),
    //   'roomNo': _roomNoController.text,
    //   'type': 'student',
    //   'notification': [],
    //   'bookmarked': [],
    //   'category': "general",
    //   'profilePic': "",
    //   'list of my filed Complaints': []
    // });
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

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   validator: (value) {
                //     if (value == "") {
                //       return 'Roll Number cannot be left Empty';
                //     }
                //     final n = num.tryParse(value);
                //     if (n == null) {
                //       return '"$value" is not a valid roll number';
                //     }
                //     if (value.length != 8)
                //       return 'Roll Number must contain 8 digits';
                //     return null;
                //   },
                //   controller: _rollNoController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(
                //     labelStyle: TextStyle(
                //       color: Colors.black,
                //     ),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(20)),
                //         borderSide: BorderSide(color: Colors.black)),
                //     labelText: 'Roll Number',
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     shape: BoxShape.rectangle,
                //     border: Border.all(color: Colors.black.withOpacity(0.3)),
                //     borderRadius: BorderRadius.all(Radius.circular(20)),
                //   ),
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton<String>(
                //       hint: Container(
                //         padding: EdgeInsets.symmetric(horizontal: 11),
                //         child: Text(
                //           'Hostel',
                //           style: Theme.of(context)
                //               .textTheme
                //               .bodyText2
                //               .copyWith(fontSize: 16),
                //         ),
                //       ),
                //       value: hostelname,
                //       onChanged: (String newValue) {
                //         setState(() {
                //           hostelname = newValue;
                //         });
                //       },
                //       isExpanded: true,
                //       style: Theme.of(context).textTheme.bodyText1,
                //       items: <String>[
                //         'C.V. Raman',
                //         'Morvi',
                //         'Dhanrajgiri',
                //         'Rajputana',
                //         'Limbdi',
                //         'Vivekanand',
                //         'Vishwakarma',
                //         'Vishweshvaraiya',
                //         'Aryabhatt-I',
                //         'Aryabhatt-II',
                //         'S.N. Bose',
                //         'Ramanujan',
                //         'Gandhi Smriti Chhatravas (OLD)',
                //         'Gandhi Smriti Chhatravas (Extension)',
                //         'IIT (BHU) Girls’ Hostel',
                //         'S.C. Dey Girls',
                //       ].map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Container(
                //             padding: EdgeInsets.symmetric(horizontal: 11),
                //             child: Text(
                //               value,
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .bodyText2
                //                   .copyWith(fontSize: 16),
                //             ),
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
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
                  controller: _roomNoController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Establishing Contact with the Server')));
                        _showDialog(context);
                        formProcessor();
                        Navigator.pop(context, '/');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => User1()));
                        // Navigator.pop(context, '/RegisterPage');
                        // Navigator.pushReplacementNamed(context, '/navigation');
                      }
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Colors.white, fontSize: 14),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text('PGMS',
                //     style: TextStyle(fontSize: 16, color: Colors.black)),
                SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

