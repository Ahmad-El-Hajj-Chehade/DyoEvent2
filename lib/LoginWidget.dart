import 'package:dyoevents20/AboutUs.dart';
import 'package:dyoevents20/Gallery.dart';
import 'package:dyoevents20/main.dart';
import 'package:dyoevents20/UserPageWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _loginWidgetState createState() => _loginWidgetState();
}

class _loginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String logInStatus = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        title: Image.asset('assets/images/logo.png', height:100, width:100, fit: BoxFit.fitWidth),


      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 300.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(

                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _auth.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          logInStatus = e.message!;
                        }
                      }
                      if(_auth.currentUser != null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserPageWidget()),
                        );
                      }
                      //dialog box
                      else{
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(logInStatus),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(10.0))),
                              content: Builder(
                                builder: (context) {
                                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                  var height = MediaQuery.of(context).size.height;
                                  var width = MediaQuery.of(context).size.width;

                                  return SizedBox(
                                    height: height - 400,
                                    width: width - 400,
                                  );
                                },
                              ),
                            )
                        );
                      }
                    },
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.purple[300]!,
              hoverColor: Colors.purple[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),

              tabs: [
                GButton(

                  icon: LineIcons.home,

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyApp()),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.infoCircle,

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  AboutUs()),

                    );
                  },
                ),
                GButton(
                  icon: LineIcons.photoVideo,

                  backgroundColor: Colors.deepPurple!,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Gallery()),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                  onPressed: () {
                    Navigator.push(

                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWidget()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
