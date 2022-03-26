import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ly_project/Pages/RaiseComplaint/raise_complaint.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:ly_project/Utils/colors.dart';
import 'package:ly_project/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  ProfileScreen({this.auth, this.onSignedOut});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  String _autoname = "";
  String _autoemail = "";
  String _autooccupation = "";
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
  TextEditingController birthdayController =
      new TextEditingController(text: 'Not Set');
  String birthdate = DateFormat.yMMMd().format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  File file;

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

  InputDecoration formFieldDecoration(String label) => InputDecoration(
        labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.black),
        ),
      );

  showAlert({
    @required String title,
    @required String message,
    @required DialogType dialogType,
  }) =>
      AwesomeDialog(
        context: context,
        dialogType: dialogType,
        animType: AnimType.BOTTOMSLIDE,
        title: title,
        desc: message,
        btnOkOnPress: () {},
      )..show();

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(1940),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate:
          birthdate == "Not set" ? DateTime.now() : DateTime.parse(birthdate),
    );
    if (date != null) {
      setState(() {
        birthdate = date.toString();
        birthdayController.text = DateFormat.yMMMMd().format(date);
        print(birthdayController.text);
      });
    }
  }

  void handleMenuClick(String value) async {
    switch (value) {
      case 'Logout':
        {
          try {
            await widget.auth.signOut();
            widget.onSignedOut();
          } catch (e) {
            print("Error in Signout!!");
            print(e);
          }
          break;
        }
    }
  }

  Future<void> autofill() async {
    try {
      final user = widget.auth.currentUserEmail();

      FirebaseFirestore.instance
          .collection('supervisors')
          .doc(user)
          .snapshots()
          .listen((data) {
        _autoname = data.data()['name'];
        birthdate = data.data()['dateOfBirth'];
        birthdayController.text =
            DateFormat.yMMMMd().format(DateTime.parse(birthdate));
        _autoemail = data.data()['email'];
        _autooccupation = "BMC Ward Supervisor";
        _autoward = data.data()['ward'];
        _autojoiningdate = DateFormat.yMMMMd()
            .format(DateTime.parse(data.data()['joiningDate']));
        _autophoneno = data.data()['mobile'];
        imageUrl = data.data()['imageUrl'];
        setState(() {
          _nameController.text = _autoname;
          _emailController.text = _autoemail;
          _occupationController.text = _autooccupation;
          _joiningdateController.text = _autojoiningdate;
          _phonenoController.text = _autophoneno;
          _wardController.text = _autoward;
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
        return WillPopScope(
          onWillPop: () {return;},
          child: alert,
        );
      },
    );
  }

  Future<void> validateAndUpdateProfile() async {
    if (validateAndSave(_formKey)) {
      _showDialog(context);
      String status = await mixtureofcalls(file);
      Navigator.pop(context);
      print(status);
      if (status == 'Success') {
        print("success k andar aaya");
        showAlert(
          title: 'Success',
          message: 'The data has been updated successfully..',
          dialogType: DialogType.SUCCES,
        );
      } else {
        showAlert(
          title: 'Error',
          message: 'Error occured while updating data..',
          dialogType: DialogType.ERROR,
        );
      }
    } else {
      print("Failure in saving the form");
    }
  }

  Future<String> mixtureofcalls(File _image) async {
    /// imageUrl is set to null when image is selected by the user
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
    print("Image download url");
    print(imageUrl);

    try {
      final emailid = widget.auth.currentUserEmail();
      await FirebaseFirestore.instance
          .collection('supervisors')
          .doc(emailid)
          .update({
        'name': _nameController.text.toString(),
        'mobile': _phonenoController.text.toString(),
        'imageUrl': imageUrl,
        'dateOfBirth': birthdate
      });
      return "Success";
    } catch (e) {
      print("Error: " + e.toString());
      return "Error";
    }
  }

  _pickImage() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      if (result != null) {
        file = File(result.files.single.path);
        print("File path from upload func: " + file.path);
        imageUrl = null;
      }
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
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
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.bold,
                  )),
              onTap: () async => await validateAndUpdateProfile(),
            ),
          ),
          SizedBox(width: size.width * 0.05),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => handleMenuClick("Logout"),
          )
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
                                        onTap: () => _pickImage(),
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
                                            style: GoogleFonts.getFont(
                                              "Oxygen",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                                        decoration: formFieldDecoration("Name"),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _emailController,
                                        decoration:
                                            formFieldDecoration("Email"),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        controller: _phonenoController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter some value";
                                          } else {
                                            RegExp regExp =
                                                new RegExp(PHONE_REGEX);
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
                                        decoration:
                                            formFieldDecoration("Phone"),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        onTap: _pickDate,
                                        controller: (birthdayController),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Date of Birth cannot be empty !';
                                          }
                                          if (value == "Not Set") {
                                            return "Please select birthdate";
                                          }
                                          if (DateTime.parse(birthdate)
                                              .isAfter(DateTime.now())) {
                                            return 'Birthdate cannot be a future date !';
                                          }
                                          return null;
                                        },
                                        decoration:
                                            formFieldDecoration("Birthdate"),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _occupationController,
                                        validator: (value) {
                                          if (value.isEmpty)
                                            return "Please enter some value";
                                          return null;
                                        },
                                        decoration:
                                            formFieldDecoration("Occupation"),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _wardController,
                                        decoration: formFieldDecoration("Ward"),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _joiningdateController,
                                        decoration:
                                            formFieldDecoration("Joining Date"),
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
}
