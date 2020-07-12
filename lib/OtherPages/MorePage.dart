import 'package:diagonal/diagonal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwm2/Classes/Constants.dart';
import 'package:jwm2/Classes/User.dart';
import 'package:jwm2/Drawer/support_page.dart';
import 'package:jwm2/Drawer/support_page_main.dart';
import 'package:jwm2/LoginPages/PhoneLogin.dart';
import 'package:jwm2/NavBar.dart';
import 'package:jwm2/OtherPages/ProfilePage.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  User userData = User();
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  FirebaseUser user;

  getUser() async {
    user = await mAuth.currentUser();
  }

  getUserData() async {
    FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;

    DatabaseReference userRef = dbRef.child('Users').child(uid);
    userRef.once().then((DataSnapshot snapshot) async {
      userData.name = await snapshot.value['Name'];
      print(userData.name);
      userData.phNo = await snapshot.value['phNo'];
      print(userData.phNo);
      userData.add1 = await snapshot.value['Add1'];
      print(userData.add1);
      userData.add2 = await snapshot.value['Add2'];
      print(userData.add2);
      userData.pin = await snapshot.value['Zip'];
      print(userData.pin);
      setState(() {
        print('Done');
      });
    });
  }

  @override
  void initState() {
    getUserData();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Diagonal(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(color: kPrimaryColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hi,',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(color: kWhiteColor, fontSize: 56.0),
                      ),
                      user == null
                          ? Text(
                              'Anonymous',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: kWhiteColor, fontSize: 40.0),
                            )
                          : Text(
                              '${userData.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: kWhiteColor, fontSize: 40.0),
                            ),
                    ],
                  ),
                ),
              ),
              position: Position.BOTTOM_LEFT,
              clipHeight: 90.0,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          size: 35.0,
                          color: kPrimaryColor,
                        ),
                        Text(
                          'Profile',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: kPrimaryColor, fontSize: 30.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUsPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.supervisor_account,
                          size: 35.0,
                          color: kPrimaryColor,
                        ),
                        Text(
                          'Support',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: kPrimaryColor, fontSize: 30.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            user == null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhoneLogin(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kPrimaryColor, width: 1.0),
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 2.0,
                                spreadRadius: 0.1),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.signInAlt,
                                size: 30.0,
                                color: kPrimaryColor,
                              ),
                              Text(
                                'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(
                                        color: kPrimaryColor, fontSize: 30.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        signOut();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kPrimaryColor, width: 1.0),
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 2.0,
                                spreadRadius: 0.1),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.signOutAlt,
                                size: 30.0,
                                color: kPrimaryColor,
                              ),
                              Text(
                                'Sign Out',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(
                                        color: kPrimaryColor, fontSize: 30.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NavBar(),
      ),
    );
  }
}
