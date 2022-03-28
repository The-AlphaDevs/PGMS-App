import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/Pages/Login/login.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/root_page.dart';
import 'package:ly_project/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              child: RegisterForm(auth: widget.auth))
        ]))),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final BaseAuth auth;
  RegisterForm({this.auth});

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
  final _passwordController = TextEditingController();

  bool _passwordVisible;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // user = FirebaseAuth.instance.currentUser;
    // _nameController.text = user.displayName;
    _passwordVisible = false;
    super.initState();
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
                      return 'Password cannot be left Empty';
                    }
                    final n = num.tryParse(value);
                    if (n == null) {
                      return '"$value" is not a valid Password';
                    }
                    if (value.length != 6)
                      return 'Password must contain 6 digits';
                    return null;
                  },
                  obscureText: !_passwordVisible,
                  // cursorColor: Colors.blue,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Password',
                    // icon: Icon(
                    //   Icons.lock,
                    //   color: Colors.blue,
                    // ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  keyboardType: TextInputType.number,
                  // decoration: InputDecoration(
                  //   labelStyle: TextStyle(
                  //     color: Colors.black,
                  //   ),
                  //   border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(20)),
                  //       borderSide: BorderSide(color: Colors.black)),
                  //   labelText: 'Password',
                  // ),
                ),

                // TextFormField(
                // validator: (value){
                //   if(value.isEmpty){
                //     return "Please enter some value";
                //   }
                //   else{
                //     if(value.length < 6){
                //       return "Minimum 6 characters atleast";
                //     }
                //   }
                //   return null;
                // },
                // obscureText: !_passwordVisible,
                // cursorColor: kPrimaryColor,
                // decoration: InputDecoration(
                //   hintText: "Password",
                //   icon: Icon(
                //     Icons.lock,
                //     color: kPrimaryColor,
                //   ),
                //   suffixIcon: IconButton(
                //     icon: Icon(
                //     // Based on passwordVisible state choose the icon
                //       _passwordVisible
                //       ? Icons.visibility
                //       : Icons.visibility_off,
                //       color: kPrimaryColor,
                //     ),
                //     onPressed: () {
                //     // Update the state i.e. toogle the state of passwordVisible variable
                //       setState(() {
                //           _passwordVisible = !_passwordVisible;
                //       });
                //     },
                //   ),
                //   border: InputBorder.none,
                //   ),
                //   onSaved: (value) => _password = value,
                // ),

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
                      if (validateAndSave()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Establishing Contact with the Server')));
                        _showDialog(context);
                        mixtureofcalls(context);
                        // loadingScreen();
                      } else {
                        print("Failure in saving the form");
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(auth: widget.auth)));
                    },
                    child: Text(
                      'Have an account? Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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

  Future<void> mixtureofcalls(BuildContext context) async {
    print("mixtureofcalls Function Call!!!!!!!!!!!!!!!!!");
    String useruid = await userCreation(context);
    print("apna Userid: " + useruid);
    if (useruid != "Error while Registering User!!") {
      store();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RootPage(auth: widget.auth)));

      // Navigator.push(context,MaterialPageRoute(builder: (context) => BottomNavBar(auth:widget.auth)));
    } else {
      print("Registration failed");
    }
  }

  Widget loadingScreen() {
    Size size = MediaQuery.of(context).size;
    return Center(
        heightFactor: MediaQuery.of(context).size.height / 64,
        // padding: EdgeInsets.all(100),
        child: Column(
          children: [
            Text('Please Wait'),
            SizedBox(height: size.height * 0.03),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ));
  }

  Future<String> userCreation(BuildContext context) async {
    print("Inside user creation function");
    try {
      User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim().toLowerCase(), password: _passwordController.text.trim()))
          .user;

      print("Registered user => " + user.uid);
      return user.uid;
    } catch (e) {
      print("Error => $e");
      if (e.toString() ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        showErrorDialog(context, "Signup Error",
            "The email address is already in use by another account.");
      } else {
        showErrorDialog(context, "Signup Error", e.toString());
      }
      return "Error while Registering User!!";
    }
  }

  Future<void> store() async {
    print("Inside store function");
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_emailController.text.toString().trim().toLowerCase())
          .set({
        'name': _nameController.text.toString(),
        'email': _emailController.text.toString().trim().toLowerCase(),
        'password': _passwordController.text.toString().trim(),
        'mobile': _phoneController.text.toString().trim(),
        'photo':
            "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
        'address': _addressController.text.toString(),
        'age': _ageController.text.toString(),
        'ward': ward,
        'date': DateTime.now().toString(),
        'occupation': occupation
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
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
}
