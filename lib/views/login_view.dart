//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '../firebase_options.dart';
import 'dart:developer' as devtools show log;

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
                devtools.log(userCredential.toString());
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/notes/',
                    (route) => false);
              } on FirebaseAuthException catch (e){
                if (e.code == 'invalid-credential'){
                  devtools.log("mot de passe ou email incorrect");
                }
              }
              catch (e){
                devtools.log('something went wrong');
                devtools.log(e.runtimeType.toString());
                devtools.log(e.toString());
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/register/', (route) => false);
              },
              child: const Text('Not registerd yet? Register here'),
          )
        ],
      ),
    );
  }
}
