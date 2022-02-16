import 'package:flutter/material.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/navigation.dart';
import 'package:ly_project/utils/constants.dart';

class RegistrationPage extends StatefulWidget {
  final BaseAuth auth;
  // final VoidCallback onsignedIn;
  RegistrationPage({this.auth});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF181D3D),
      child: SafeArea(
        child: Scaffold(
            body: Container(
                child: ListView(children: [
          // Container(
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Color(0xFF181D3D),
          //       ),
          //       borderRadius: BorderRadius.all(Radius.circular(20))),
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height / 8,
          //    Container(
          //     constraints: BoxConstraints.expand(),
          //     color: Color(0xFF181D3D),
          //     child: Column(children: [
          //       SizedBox(height: MediaQuery.of(context).size.height / 16),
          //       Text(
          //         'Sign Up',
          //         style: Theme.of(context)
          //             .textTheme
          //             .headline5
          //             .apply(color: Colors.white),
          //       )
          //     ]),
          //   )),
          Container(
              decoration: BoxDecoration(
                  color: Color(0xFF181D3D),
                  border: Border.all(
                    color: Color(0xFF181D3D),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              child: Center(
                child: Text(
                  "Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .apply(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 20),
              child: RegisterForm())
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
  String ward = "Ward A";
  String occupation = "Business";
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _ageController = TextEditingController();
  // final _occupationController = TextEditingController();
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
              margin: EdgeInsets.only(left: 7),
              child: Text("  Registering...")),
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
                TextFormField(
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Name cannot be left Empty';
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Age cannot be left Empty';
                    }
                    final n = num.tryParse(value);
                    if (n == null) {
                      return '"$value" is not a valid age';
                    }
                    if (int.parse(value) > 125 || int.parse(value) < 5) {
                      return "Enter valid age! (5-125)";
                    }
                    return null;
                  },
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Age',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Email cannot be left Empty';
                    }
                    String p =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = new RegExp(p);
                    if (!regExp.hasMatch(value)) {
                      return 'Enter a valid email';
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
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return 'Phone Number cannot be left Empty';
                    }
                    final n = num.tryParse(value);
                    if (n == null) {
                      return '"$value" is not a valid phone number';
                    }
                    if (value.length != 10)
                      return 'Phone Number must contain 10 digits';
                    return null;
                  },
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Phone Number',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Container(
                        padding: EdgeInsets.symmetric(horizontal: 11),
                        child: Text(
                          'Occupation',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      value: occupation,
                      onChanged: (String occ) {
                        setState(() {
                          occupation = occ;
                        });
                      },
                      isExpanded: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      items: OCCUPATIONS
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text(
                              value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Container(
                        padding: EdgeInsets.symmetric(horizontal: 11),
                        child: Text(
                          'Ward',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      value: ward,
                      onChanged: (String selectedWard) {
                        setState(() {
                          ward = selectedWard;
                        });
                      },
                      isExpanded: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      items:
                          WARDS.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text(
                              value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Address cannot be left Empty';
                    }
                    return null;
                  },
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 45,
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Establishing Contact with the Server')));
                        _showDialog(context);
                        formProcessor();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => User1()),
                        );
                        // Navigator.pop(context, '/');
                        // Navigator.pop(context, '/RegisterPage');
                        // Navigator.pushReplacementNamed(context, '/navigation');
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    highlightElevation: 5,
                    color: Color(0xFF181D3D),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Have an account? Sign In',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 12),
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