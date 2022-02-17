import 'package:flutter/material.dart';
import 'package:ly_project/root_page.dart';
import 'package:ly_project/Pages/Registration/registration.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Auth auth = new Auth();
  // await auth.signOut();
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

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("abc"),
//     ),
//     body: Container(child: Text("Hello")),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => RegistrationPage()),
//         );
//       },
//       tooltip: 'Increment',
//       child: Icon(Icons.add),
//     ),
//   );
// }
