import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test4/firebase_options.dart';
import 'package:test4/views/login_view.dart';
import 'package:test4/views/register_view.dart';




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
          Text('Please verify your email address:'),
          TextButton(
              onPressed: () async{
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Send email verification')
          )
        ],),
    );
  }
}