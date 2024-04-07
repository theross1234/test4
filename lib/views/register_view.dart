import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test4/constant/routes.dart';
import '../firebase_options.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(title: const Text('Register'),
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
              final email = _email.text;
              final password = _password.text;
              try{
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: email, password: password);
                devtools.log(userCredential.toString());
                Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute, (route) => false);
              }on FirebaseAuthException catch (e){
                if (e.code == 'weak-password') {
                  devtools.log('week password');
                }else if (e.code == 'email-is-already-in-use'){
                  devtools.log('email is already in suse');
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute, (route) => false);
            },
            child: const Text('already register ? login year'),
          )
        ],
      ),
    );
  }
}