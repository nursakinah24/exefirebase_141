import 'package:flutter/material.dart';
import 'package:flutterfirebase/controller/auth_controller.dart';
import 'package:flutterfirebase/model/user_model.dart';
import 'package:flutterfirebase/view/login.dart';

class Register extends StatelessWidget {
   Register({super.key});

  final form = GlobalKey<FormState>();

  final authCtrl = AuthController();

  @override
  Widget build(BuildContext context) {
    String? name;
    String? email;
    String? password;

    return Scaffold(
        appBar: AppBar(
        title: Text('Register'),
      ),
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(key: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 100.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: ((value) {
                name = value;
              }),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: ((value) {
                email = value;
              }),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (value) {
                password = value;
              }, obscureText: true,
            ),
            const SizedBox(height: 29),
            ElevatedButton(
              onPressed: () async {
                if (form.currentState!.validate()) {
                  UserModel? registeredUser = await authCtrl
                      .registerWithEmailAndPassword(email!, password!, name!);
                  if (registeredUser != null) {
                    // Registration successful
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Registration Successful'),
                          content: const Text(
                              'You have been successfully registered.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                     Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Login();
                                  })); 
                                // Navigate to the next screen or perform any desired action
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Registration failed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Registration Failed'),
                          content: const Text(
                              'An error occurred during registration.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                },
                child: const Text('Login'),
              ),
          ],
        ),
      ),
    ));
  }
}
