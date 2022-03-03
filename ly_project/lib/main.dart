import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/root_page.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart'

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseStorage storage = FirebaseStorage.instance;
  // FirebaseStorage.instance.refFromURL("https://firebasestorage.googleapis.com/v0/b/pgms-65b22.appspot.com/o/VFJY5LTumRdJoA7fD4JNsoGPOR62%2FIMG_20220227_152851.jpg?alt=media&token=ddb27bc5-3cd3-4dd3-9003-f7828721a805").delete();
//   photoRef.delete().addOnSuccessListener(new OnSuccessListener<Void>() {
//     @override
//     public void onSuccess(Void aVoid) {
//         // File deleted successfully
//         Log.d(TAG, "onSuccess: deleted file");
//     }
//     }).addOnFailureListener(new OnFailureListener() {
//     @override
//     public void onFailure(@NonNull Exception exception) {
//         // Uh-oh, an error occurred!
//         Log.d(TAG, "onFailure: did not delete file");
//     }
// });
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootPage(auth: Auth()),
    );
  }
}
