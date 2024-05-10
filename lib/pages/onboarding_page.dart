import 'package:final_year_project/components/my_button.dart';
import 'package:final_year_project/pages/auth_page.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage('lib/assets/kadpoly.jpg'))),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
            ),
            const Text(
              'Staff pension management system for Kaduna Polytechnic',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: MyButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AuthPage())));
                  },
                  text: 'Click to proceed'),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Project by: Aaron Jibrin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
