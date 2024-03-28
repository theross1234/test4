import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test4/firebase_options.dart';
import 'package:test4/views/login_view.dart';
import 'package:test4/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
    body: FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user?.emailVerified ?? false){

            }else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyEmailViews()));
              });
            }
            return const Text('Done');
          default:
            return const Text('Loading....');
         }
       },
      ),
    );
  }
}

class VerifyEmailViews extends StatefulWidget {
  const VerifyEmailViews({super.key});

  @override
  State<VerifyEmailViews> createState() => _VerifyEmailViewsState();
}

class _VerifyEmailViewsState extends State<VerifyEmailViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify email'),
      ),
    );
  }
}

