// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:daybook/Provider/email_sign_in.dart';
// import 'package:daybook/Services/user_services.dart';
// import 'package:daybook/Utils/constantStrings.dart';
// import 'package:daybook/Utils/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ly_project/Pages/RaiseComplaint/raise_complaint.dart';
import 'package:ly_project/Services/auth.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

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

  String noOfEntries = "";
  String noOfJourneys = "";
  String noOfTasks = "";
  String noOfHabits = "";

  String name = "User";
  String birthdate = "2000-12-12";
  String email = "user@email.com";
  String dateJoined = "2021-12-01";
  String gender = "Male";
  String userType = "User";

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _birthdateController = new TextEditingController();

  final List<String> menuItems = <String>[
    'Logout',

  ];

  @override
  void initState() {
    super.initState();
  }

  void handleMenuClick(String value) async {
    switch (value) {
      case 'Logout':
        {
            // void _signOut(BuildContext context) async {
            try {
              await widget.auth.signOut();
              widget.onSignedOut();
            } catch (e) {
              print("Error in Signout!!");
              print(e);
            }
          // }
          break;
        }
  }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<String>(
              onSelected: handleMenuClick,
              itemBuilder: (BuildContext context) {
                return menuItems.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          title: Text(
            "My Profile",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        key: _scaffoldKey,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 200,
                width: double.infinity,
                // color: Color(0xFF181D3D),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: CachedNetworkImage(
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                      imageUrl: "https://picsum.photos/200/300",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            name
                                                .split(" ")
                                                .map((str) =>
                                                    str[0].toUpperCase() +
                                                    str.substring(1))
                                                .join(" "),
                                            style: GoogleFonts.getFont("Oxygen",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                // color: Colors.white,
                                                ),
                                            softWrap: true,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "User since $dateJoined",
                                          style: GoogleFonts.getFont("Lato",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              // color: Colors.white,
                                              ),
                                        ),
                                      ]),
                                ]),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                child: FloatingActionButton(
                                  backgroundColor: Color(0xFF181D3D),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 15,
                                  ),
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RaiseComplaint()),
                                    ),
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                  labelText:"Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(color: Colors.black)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    name
                                        .split(" ")
                                        .map((str) =>
                                            str[0].toUpperCase() +
                                            str.substring(1))
                                        .join(" "),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFF181D3D),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                  labelText:"E-mail",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(color: Colors.black)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    email,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFF181D3D),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _genderController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                  labelText:"Gender",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(color: Colors.black)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gender,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFF181D3D),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _birthdateController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                  labelText:"BirthDate",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(color: Colors.black)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    birthdate,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFF181D3D),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              SizedBox(height: 20),
                              userType == "email"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Center(
                                        child: MaterialButton(
                                          child: Text("Change password",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color(0xff5685bf),
                                              )),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 10),
                                          shape: StadiumBorder(),
                                          color: Color(0xff8ebbf2),
                                          onPressed: () async {
                                            print(
                                                "Navigate to change password screen...");
                                            // await showPasswordResetDialog();
                                            print("Email sent!!");
                                          },
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                   
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.grey.shade200,
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: Colors.white,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ]);

class AvatarImage extends StatelessWidget {
  String url;
  AvatarImage(String url) {
    this.url = url;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          // child: CachedNetworkImage(
          //                   fit: BoxFit.cover,
          //                   imageUrl: url,
          //                 ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider('assets/images/All-Done.png'),
            ),
          ),
        ),
      ),
    );
  }
}
