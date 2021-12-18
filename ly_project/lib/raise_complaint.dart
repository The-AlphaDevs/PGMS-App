import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ly_project/utils/DashedRect.dart';

class RaiseComplaint extends StatefulWidget {
  const RaiseComplaint({Key key}) : super(key: key);

  @override
  _RaiseComplaintState createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {
  final _localityController = TextEditingController();
  final _grievanceController = TextEditingController();
  // final _nController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Raise a complaint"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          // padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  color: Colors.red,
                  child: CachedNetworkImage(
                    imageUrl: "https://i.stack.imgur.com/RdkOb.jpg",
                    width: MediaQuery.of(context).size.width / 1.2,
                  )),
              SizedBox(height: 40),
              TextFormField(
                controller: _localityController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  labelText: 'Locality',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _grievanceController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  labelText: 'Grievance',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(height: 20),
              // TextFormField(
              //   // controller: _nameController,
              //   decoration: InputDecoration(
              //     labelStyle: TextStyle(
              //       color: Colors.black,
              //     ),
              //     labelText: 'Photo',
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         borderSide: BorderSide(color: Colors.black)),
              //   ),
              // ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    color: Colors.black12,
                    child: DashedRect(
                      color: Colors.red,
                      strokeWidth: 2.0,
                      gap: 3.0,
                    ),
                    // child: IconButton(
                    //     icon: Icon(Icons.image),
                    //     onPressed: () => {print("Trying to upload the image...")})
                  ),
                  IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () => {print("Trying to upload the image...")})
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 10.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  elevation: 5.0,
                  color: Colors.blue,
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                      onPressed: null,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 10),
                            Text("Add Complaint",
                                style: TextStyle(color: Colors.white))
                          ])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
