import 'package:final_year_project/pages/login_page.dart';
import 'package:final_year_project/pages/page_option.dart';
import 'package:final_year_project/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user loged in
            if (snapshot.hasData) {
              return PageOption();
            } else {
              return showLoginPage
                  ? LoginPage(
                      onTap: () {
                        togglePages();
                      },
                    )
                  : RegisterPage(onTap: togglePages);
            }
            // user not loged in
          }),
    );
  }
}
