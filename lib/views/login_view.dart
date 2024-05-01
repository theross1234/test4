//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;
import 'package:test4/constant/routes.dart';
import '../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'email'
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
                hintText: 'password'
            ),
          ),
          TextButton(
            onPressed: () async {
              final Lemail = _email.text;
              final Lpassword = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                    email: Lemail,
                    password: Lpassword
                );
                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false){
                  // user is verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                        notesRoute, (route) => false);
                }else {
                  // user's email is not verified
                  Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                }
                devtools.log(userCredential.toString());
                Navigator.of(context).pushNamedAndRemoveUntil(
                   verifyEmailRoute,
                   (route) => false
                );
              } on FirebaseAuthException catch (e){
                if (e.code == 'invalid-credential'){
                  await showErrorDialog(
                    context,
                    'wrong credentials',
                  );
                } else if (e.code == 'wrong-password'){
                  await showErrorDialog(
                      context,
                      'wrong credentials'
                  );
                }else {
                  await showErrorDialog(
                      context,
                      'Error: ${e.code}',);
                }
              }
              catch (e){
                /*devtools.log('something went wrong');
                devtools.log(e.runtimeType.toString());
                devtools.log(e.toString());*/
                await showErrorDialog(context, e.toString(),);
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute, (route) => false);
              },
              child: const Text('Not registerd yet? Register here'),
          )
        ],
      ),
    );
  }
}

