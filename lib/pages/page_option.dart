import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/pages/home_page.dart';
import 'package:final_year_project/pages/pension_info_page.dart';
import 'package:flutter/material.dart';

class PageOption extends StatefulWidget {
  const PageOption({super.key});

  @override
  State<PageOption> createState() => _PageOptionState();
}

class _PageOptionState extends State<PageOption> {
  void checkInfo() async {
    if (await FirebaseFirestore.instance
            .collection("pensionDetails")
            .snapshots() ==
        Stream.empty()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ////////////
      ///
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PensionInfoPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
