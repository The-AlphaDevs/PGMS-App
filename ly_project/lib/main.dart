import 'package:flutter/material.dart';
// import "package:latlong/latlong.dart";
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:ly_project/root_page.dart';
import 'registration.dart';
// import 'registration.dart';
import 'auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'landing.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: RootPage(auth: Auth()),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("abc"),
    ),
    body: Container(child: Text("Hello")),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistrationPage()),
        );
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ),
  );
}
