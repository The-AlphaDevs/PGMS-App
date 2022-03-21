import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ly_project/Pages/RaiseComplaint/raise_complaint.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:async';

import 'package:ly_project/Utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  final BaseAuth auth;
  ProfileScreen({@required this.auth});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  String _name = "";
  String _email = "";
  String _age = "";
  String _occupation = "";
  String _address = "";
  String _ward = "";
  String _joiningdate = "";
  String _phoneno = "";

  String _autoname = "";
  String _autoemail = "";
  String _autoage = "";
  String _autooccupation = "";
  String _autoaddress = "";
  String _autoward = "";
  String _autojoiningdate = "";
  String _autophoneno = "";
  String fileurl;
  String userType = "User";
  String imageUrl =
      "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phonenoController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _occupationController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _wardController = new TextEditingController();
  TextEditingController _joiningdateController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File file;

  final List<String> menuItems = <String>['Logout'];

  @override
  void initState() {
    autofill();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phonenoController.dispose();
    _ageController.dispose();
    _occupationController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _wardController.dispose();
    _joiningdateController.dispose();
    super.dispose();
  }

  AlertDialog logOutAlert() {
    Widget okButton = OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
      child: Text("Yes", style: TextStyle(color: Colors.grey[700])),
      onPressed: () async {
        try {
          Navigator.pop(context, null);
          await widget.auth.signOut();
        } catch (e) {
          print("Error in Signout!!");
          print(e);
        }
      },
    );
    Widget cancelButton = OutlinedButton(
      autofocus: true,
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: Colors.green)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
      child: Text("No", style: TextStyle(color: Colors.green[900])),
      onPressed: () => Navigator.pop(context, null),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Wait!"),
      content: Text("Do you want to log out?"),
      actions: [okButton, cancelButton],
      titlePadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
      contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 8.0),
      actionsPadding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
    );
    return alert;
  }

  void handleMenuClick(String value) async {
    switch (value) {
      case 'Logout':
        {
          showDialog(
            context: context,
            builder: (BuildContext context) => logOutAlert(),
          );

          break;
        }
    }
  }

  Future<void> autofill() async {
    try {
      final user = widget.auth.currentUserEmail();
      print(user);
      FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .snapshots()
          .listen((data) {
        setState(() {
          _autoname = data.data()['name'];
          _autoage = data.data()['age'];
          _autoemail = data.data()['email'];
          _autooccupation = data.data()['occupation'];
          _autoaddress = data.data()['address'];
          _autoward = data.data()['ward'];
          _autojoiningdate = data.data()['date'];
          _autophoneno = data.data()['mobile'];

          imageUrl = data.data()['photo'];

          print('autofill Name: $_autoname');
          print('autofill Phone Number: $_autophoneno');
          print('autofill Email: $_autoemail');
          print('autofill Age: $_autoage');
          print('autofill Occupation: $_autooccupation');
          print('autofill Address: $_autoaddress');
          print('autofill Ward: $_autoward');
          print('autofill Joining Date: $_autojoiningdate');

          _nameController = TextEditingController(text: _autoname);
          _ageController = TextEditingController(text: _autoage);
          _emailController = TextEditingController(text: _autoemail);
          _occupationController = TextEditingController(text: _autooccupation);
          _addressController = TextEditingController(text: _autoaddress);
          _joiningdateController =
              TextEditingController(text: _autojoiningdate);
          _phonenoController = TextEditingController(text: _autophoneno);
          _wardController = TextEditingController(text: _autoward);
        });
      });
    } catch (e) {
      print("Error: " + e);
    }
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
              child: Text("Updating Data...")),
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: DARK_BLUE,
        actions: [
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Text("SAVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.bold,
                  )),
              onTap: () async {
                if (validateAndSave(_formKey)) {
                  _showDialog(context);
                  String status = await mixtureofcalls(file);
                  print("mixture of calls ho gaya");
                  Navigator.pop(context);
                  print("context pop hua");
                  if (status == 'Success') {
                    print("success k andar aaya");
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Success',
                      desc: 'The data has been updated successfully..',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  } else {
                    print("else k andar aaya");

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Error',
                      desc: 'Error occured while updating data..',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  }
                } else {
                  print("Failure in saving the form");
                }
              },
            ),
          ),
          SizedBox(width: size.width * 0.05),
          IconButton(
              icon: Icon(Icons.logout, size: size.height * 0.025),
              onPressed: () => handleMenuClick("Logout"))
        ],
        title: Text(
          "My Profile",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: size.width * 0.12,
                                          child: CircleAvatar(
                                            radius: size.width * 0.11,
                                            backgroundColor: Colors.white,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fitWidth,
                                                imageUrl: imageUrl,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () => _upload(),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.53,
                                          child: Text(
                                            _nameController.text,
                                            style: GoogleFonts.getFont("Oxygen",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: _nameController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter some value";
                                          } else {
                                            if (value.length < 3) {
                                              return "Minimum length must be 3";
                                            }
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          labelText: "Name",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        onSaved: (value) => _name = value,
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          labelText: "E-mail",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        onSaved: (value) => _email = value,
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        controller: _phonenoController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter some value";
                                          } else {
                                            String patttern =
                                                r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                            RegExp regExp =
                                                new RegExp(patttern);
                                            if (value.length != 10) {
                                              return "Mobile Number must be of 10 digits";
                                            } else {
                                              if (!regExp.hasMatch(value)) {
                                                return "Please enter valid Mobile Number";
                                              }
                                            }
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          labelText: "Phone No.",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        onSaved: (value) => _phoneno = value,
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        controller: _ageController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter some value";
                                          } else {
                                            if (int.parse(value) < 1 ||
                                                int.parse(value) > 100) {
                                              return "Age must be between 1 and 100";
                                            }
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          labelText: "Age",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        onSaved: (value) => _age = value,
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        controller: _occupationController,
                                        validator: (value) {
                                          if (value.isEmpty)
                                            return "Please enter some value";
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          labelText: "Occupation",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                        onSaved: (value) => _occupation = value,
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _addressController,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          labelText: "Address",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        onSaved: (value) => _address = value,
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _wardController,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          labelText: "Ward",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        onSaved: (value) => _ward = value,
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _joiningdateController,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          labelText: "Joining Date",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        onSaved: (value) =>
                                            _joiningdate = value,
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> mixtureofcalls(File _image) async {
    print("Inside mixtureofcalls function");
    if (imageUrl == null) {
      final user = await widget.auth.currentUser();
      print(user);
      String imageRef = user + '/' + _image.path.split('/').last;
      print(imageRef);
      imageUrl =
          await (await FirebaseStorage.instance.ref(imageRef).putFile(_image))
              .ref
              .getDownloadURL();
    }
    print(imageUrl);

    try {
      final emailid = widget.auth.currentUserEmail();
      await FirebaseFirestore.instance.collection('users').doc(emailid).update({
        'name': _name,
        'email': _email,
        'date': _joiningdate,
        'occupation': _occupation,
        'address': _address,
        'age': _age,
        'ward': _ward,
        'mobile': _phoneno,
        'photo': imageUrl
      });
      return "Success";
    } catch (e) {
      print("Error: " + e.toString());
      return "Error";
    }
  }

  _upload() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path);
      print("File path from upload func: " + file.path);
      imageUrl = null;
    }
    setState(() {});
  }


}
