import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test4/constant/routes.dart';
import 'package:test4/utilities/show_error_dialog.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: email, password: password);
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(
                    verifyEmailRoute);
              }on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  await showErrorDialog(context, 'weak password');
                  devtools.log('week password');
                } else if (e.code == 'email-is-already-in-use') {
                  await showErrorDialog(
                      context, 'this email is already in use');
                  devtools.log('email is already in suse');
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(
                      context, 'invalid email');
                  devtools.log('invalid email');
                } else if (e.code == 'invalid-credentials') {
                  await showErrorDialog(
                      context, 'invalid credential');
                  devtools.log('invalid credential');
                }  else {
                  await showErrorDialog(context, 'Error ${e.code}',);
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