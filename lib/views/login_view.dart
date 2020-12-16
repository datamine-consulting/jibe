import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jibe/models/signin_model.dart';
import 'package:jibe/base/base_view.dart';
import 'package:jibe/splash.dart';
import 'package:jibe/utils/auth.dart';
import 'package:jibe/utils/routeNames.dart';
import 'package:jibe/utils/util.dart';
import 'package:jibe/utils/view_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _userLoginFormKey = GlobalKey();
  final Auth _auth = Auth();
  User _user;

  bool isSignIn = false;
  bool google = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
        onModelReady: (model) {},
        builder: (context, model, build) {
          return WillPopScope(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xFFE6E6E6),
                body: Stack(
                  children: <Widget>[
                    Container(
                      height: 410,
                      width: 430,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: deviceSize.height / 2.4,
                            width: deviceSize.width / 3,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/weddinglogo.png'),
                              ),
                            ),
                          ),
                          Container(
                            child: Form(
                              key: _userLoginFormKey,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 15, left: 10, right: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 25),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0,
                                            right: 14,
                                            left: 14,
                                            bottom: 8),
                                        child: TextFormField(
                                          controller: model.userIdController,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            hintText: "Email",
                                            hintStyle: TextStyle(fontSize: 15),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                          ),
                                          cursorColor: Colors.black,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .singleLineFormatter,
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0,
                                            right: 14,
                                            left: 14,
                                            bottom: 8),
                                        child: TextFormField(
                                          controller: model.passwordController,
                                          obscureText: !model.passwordVisible,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            hintText: "Password",
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            hintStyle: TextStyle(fontSize: 15),
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                  model.passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Color(0xFFE6E6E6),
                                                ),
                                                onPressed: () {
                                                  model.passwordVisible =
                                                      !model.passwordVisible;
                                                }),
                                          ),
                                          cursorColor: Colors.black,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .singleLineFormatter,
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      InkWell(
                                        child: Container(
                                            width: deviceSize.width / 2,
                                            height: deviceSize.height / 18,
                                            margin: EdgeInsets.only(top: 25),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/google.jpg'),
                                                        fit: BoxFit.cover),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  'Sign in with Google',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ))),
                                        onTap: () async {
                                          model.loginWithGoogle();
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    model.state == ViewState.Busy
                        ? Utils.progressBar()
                        : Container(),
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              model.clearAllModels();
              return false;
            },
          );
        });
  }
}
