import 'package:flutter/material.dart';

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
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text("MAP"),
            ),
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
            TextFormField(
              // controller: _nameController,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Photo',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            RaisedButton(onPressed: null, child: Text("Add Complaint"))
          ],
        ),
      ),
    );
  }
}
