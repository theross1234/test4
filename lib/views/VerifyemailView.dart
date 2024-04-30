import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test4/constant/routes.dart';

class VerifyEmailViews extends StatefulWidget {
  const VerifyEmailViews({super.key});

  @override
  State<VerifyEmailViews> createState() => _VerifyEmailViewsState();
}

class _VerifyEmailViewsState extends State<VerifyEmailViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text('We have sent an email address verification please open it to verify your account'),
          const Text('if you have not receive a verification adress press the button below'),
          TextButton(
              onPressed: () async{
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Send email verification')
          ),
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Restart'))
        ],),
    );
  }
}