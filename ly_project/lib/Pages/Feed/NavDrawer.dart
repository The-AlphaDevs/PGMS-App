import 'package:flutter/material.dart';
import 'package:ly_project/Services/auth.dart';
import 'package:ly_project/root_page.dart';

class NavDrawer extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  NavDrawer({this.auth, this.onSignedOut});
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  // Sidebar Switches
  bool isSwitched1 = true;
  bool isSwitched2 = true;
  bool isSwitched3 = true;
  bool isSwitched4 = true;

  Map<String, bool> categoryComaplints = {
    "Potholes": false,
    "Sewage": false,
    "Electricity": false,
    "Garbage": false,
  };

  ValueNotifier<Map<String, bool>> _filter;

  @override
  void initState() {
    super.initState();
    categoryComaplints = {
      "Potholes": isSwitched1,
      "Sewage": isSwitched2,
      "Electricity": isSwitched3,
      "Garbage": isSwitched4,
    };
    _filter = ValueNotifier<Map<String, bool>>(categoryComaplints);
  }

  void _signOut(BuildContext context) async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print("Error in Signout!!");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(categoryComaplints);
    // return StreamBuilder<DocumentSnapshot>(
    //   // stream: UpdateNotification().userssnap,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: Expanded(
          child: Column(
            children: [
              DrawerHeader(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/third');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8.0,
                          color: Colors.black54,
                          spreadRadius: 0.9,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage:
                          // snapshot.data.data()['profilePic'] == ""?
                          AssetImage('assets/blankProfile.png'),
                      // : NetworkImage(
                      //     snapshot.data.data()['profilePic']),
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  color: Color(0xFF181D3D),
                  child: ListTile(
                    title: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          // "Hi, ${snapshot.data.data()['name']}",
                          "Hi, Sharmaji",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'JosefinSans',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(2.0),
                children: [
                  ExpansionTile(
                    leading: Icon(
                      Icons.filter_list,
                      color: Color(0xFF181D3D),
                    ),
                    title: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    children: [
                      ListTile(
                        leading: Switch(
                          value: isSwitched1,
                          onChanged: (bool value) {
                            setState(() {
                              isSwitched1 = value;
                              categoryComaplints["Potholes"] = isSwitched1;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Potholes'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched2,
                          onChanged: (value) {
                            setState(() {
                              isSwitched2 = value;
                              categoryComaplints["Sewage"] = isSwitched2;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Sewage'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched3,
                          onChanged: (value) {
                            setState(() {
                              isSwitched3 = value;
                              categoryComaplints["Electricity"] = isSwitched3;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Electricity'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched4,
                          onChanged: (value) {
                            setState(() {
                              isSwitched4 = value;
                              categoryComaplints["Garbage"] = isSwitched4;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Garbage'),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 0.5,
                color: Color(0xFF181D3D),
                thickness: 0.5,
                indent: 15.0,
                endIndent: 15.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Color(0xFF181D3D),
                ),
                title: Text('About'),
                onTap: () => {},
                // Navigator.pushNamed(context, '/about')
              ),
              Divider(
                height: 0.5,
                color: Color(0xFF181D3D),
                thickness: 0.5,
                indent: 15.0,
                endIndent: 15.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.reply,
                  color: Color(0xFF181D3D),
                ),
                title: Text('Log Out'),
                onTap: () async {
                  // Auth auth = widget.authnew Auth();
                  _signOut(context);
                  // Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
