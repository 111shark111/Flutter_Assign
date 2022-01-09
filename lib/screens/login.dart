import 'package:flutter_application_1/screens/homeScreen.dart';
import 'package:flutter_application_1/utils/LoginList.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void loginHandler(BuildContext ctx) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      for (int i = 0; i < LoginList.userData.length; i++) {
        if (name == LoginList.userData[i]['name'] &&
            password == LoginList.userData[i]['password']) {
          try {
            final SharedPreferences sharedpref =
                await SharedPreferences.getInstance();
            await sharedpref.setInt('id', i);
          } catch (err) {
            //  print(err);
          }
          Navigator.push(ctx, MaterialPageRoute(builder: (ctx) {
            return HomeScreen(id: i);
          }));
          return;
        } else {
          // print('Not here in $i');
        }
      }
    }
  }

// Add Shared Preferences work and work on UI of this app to do ..... major functionality is done ... push to git to-do

  var name;
  var password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.network(
                'https://i.pinimg.com/736x/e4/dc/f8/e4dcf8cb402b157ae7dcebad8bbf9e01--mobile-ui-platform.jpg'),
          ),
          Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Enter Username',
                          labelText: 'Username',
                        ),
                        onSaved: (value) {
                          name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Username";
                          } else if (value.length < 3) {
                            return "Number of Characters should be more than 3";
                          } else if (value.length > 11) {
                            return "Number of Characters should be less than 11";
                          }
                          return null;
                        }),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                    ),
                    TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          hintText: 'Enter Password',
                          labelText: 'Password',
                        ),
                        onSaved: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          } else if (value.length < 3) {
                            return "Number of Characters should be more than 3";
                          } else if (value.length > 11) {
                            return "Number of Characters should be less than 11";
                          }
                          return null;
                        }),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                    ),
                    ElevatedButton(
                      onPressed: () => loginHandler(context),
                      child: const Text('Login'),
                    )
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
