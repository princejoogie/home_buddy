import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy/host_details.dart';
import 'package:home_buddy/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  final String email, username, firstName, lastName, profileImage, coverImage;
  ProfileTab(
      {this.email,
      this.username,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.coverImage});

  @override
  _ProfileTabState createState() => _ProfileTabState(
      email, username, firstName, lastName, profileImage, coverImage);
}

class _ProfileTabState extends State<ProfileTab> {
  String email, username, firstName, lastName, profileImage, coverImage;

  _ProfileTabState(
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.coverImage,
  );

  Future<void> _putUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', null);
    await prefs.setString('username', null);
    await prefs.setString('firstName', null);
    await prefs.setString('lastName', null);
    await prefs.setString('profileImage', null);
    await prefs.setString('coverImage', null);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      radius: 25,
                      onTap: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    username,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      radius: 25,
                      onTap: () async {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          child: new CupertinoAlertDialog(
                            title: new Column(
                              children: <Widget>[
                                Text("Alert"),
                                SizedBox(height: 10),
                              ],
                            ),
                            content: Text("Are you Sure you want to Log Out?"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: new Text("CANCEL"),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  await _putUserData();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginScreen(),
                                    ),
                                  );
                                },
                                child: new Text("OK"),
                              )
                            ],
                          ),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          bottom: 0,
          right: 0,
          left: 0,
          child: ListView(
            children: <Widget>[
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                            ),
                            color: Color(0xFF6FBAF7),
                          ),
                          child: coverImage == 'cover_image.png'
                              ? RaisedButton(onPressed: () {})
                              : ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0),
                                  ),
                                  child: Image(
                                    image: NetworkImage(baseUrl + coverImage),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 175,
                        width: 175,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(175 / 2),
                          border: Border.all(
                            color: Color(0xFFF2F2F2),
                            width: 5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(175 / 2),
                          child: profileImage == null
                              ? Container()
                              : Image(
                                  image: NetworkImage(baseUrl + profileImage),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: (MediaQuery.of(context).size.width / 2 - 20) - 50,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF007BFF),
                          borderRadius: BorderRadius.circular(175 / 2),
                          border: Border.all(
                            color: Color(0xFFF2F2F2),
                            width: 3,
                          ),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            radius: 25,
                            onTap: () async {},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Color(0xFF007BFF),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        firstName + " " + lastName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "email: ",
                            style: TextStyle(
                              color: Color(0xFF7B7676),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
