import 'package:application1/userInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:application1/main_menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Image.asset(
                '../assets/images/driving-school-logo.jpg',
                height: 200,
                width: 200,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Login',
                      style:
                      TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: usernameController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        // icon: Icon(Icons.mail),
                          prefixIcon: Icon(Icons.mail),
                          suffixIcon: usernameController.text.isEmpty
                              ? Text('')
                              : GestureDetector(
                              onTap: () {
                                usernameController.clear();
                              },
                              child: Icon(Icons.close)),
                          hintText: 'type your username',
                          labelText: 'Username',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                              BorderSide(color: Colors.red, width: 1))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      obscureText: isVisible,
                      controller: passwordController,
                      onChanged: (value) {
                        print(value);
                      },
                      //
                      decoration: InputDecoration(
                        // icon: Icon(Icons.mail),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                isVisible = !isVisible;
                                setState(() {});
                              },
                              child: Icon(isVisible ? Icons.visibility : Icons.visibility_off)),
                          hintText: 'type your password',
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                              BorderSide(color: Colors.red, width: 1))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if(usernameController.text.toString() == "user" && passwordController.text.toString() == "user")
                          {
                            User.setInfo(usernameController.text.toString(), passwordController.text.toString());
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MainMenu()),
                            );
                            }
                          else
                            {
                              showDialog(context: context, builder: (context) {
                                return const SimpleDialog(
                                  title: Text('Cannot Login, Enter the Following Data'),
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.mail),
                                      title: Text('user'),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.lock),
                                      title: Text('user'),
                                    ),
                                  ],
                                );
                              });
                            }

                        }, child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text('Login'),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}