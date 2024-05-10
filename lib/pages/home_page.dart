import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/components/my_button.dart';
import 'package:final_year_project/components/my_textfield.dart';
import 'package:final_year_project/pages/login_or_register.dart';
import 'package:final_year_project/pages/pension_info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController allowance = TextEditingController();
  TextEditingController administrator = TextEditingController();
  TextEditingController employeeContribution = TextEditingController();
  TextEditingController employerContribution = TextEditingController();

////////////////////////////

  double basicMS = 0;
  double hTOA = 0;
  double employeeCont = 0;
  double employerCont = 0;

  // ///////////////////////

  double employeePenContr = 0;
  double employerPenContr = 0;
  double totalPenContr = 0;

//////////////////////////
  ///
  void pensionCalculator() {
    setState(() {
      employeePenContr = (basicMS * (employeeCont / 100));
      employerPenContr = (hTOA * (employerCont / 100));
      totalPenContr = employeePenContr + employerPenContr;

      firestore.collection("pensionDetails").add({
        "firstName": firstName.text,
        "lastName": lastName.text,
        "pensionAdministrator": administrator.text,
        "employeeContribution": employeePenContr.toString(),
        "employerContribution": employerPenContr.toString(),
        "totalContribution": totalPenContr.toString(),
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "id": firestore.collection("pensionDetails").doc().id,
      });
    });
  }

  ////////////////////
  ///
  final firestore = FirebaseFirestore.instance;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFF1F9FD),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((value) =>
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginOrRegister())));
                            },
                            icon: const Icon(
                              Icons.logout,
                              size: 30,
                            )),
                        const Text('logout'),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),

                    const Text(
                      'Fill in your pension details correctly',
                      style: TextStyle(fontSize: 20),
                    ),
                    // NAME
                    // first name
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, right: 2),
                            child: MyTextField(
                                controller: firstName,
                                hintText: 'First Name',
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "First Name is Required";
                                  }
                                  if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                                    return "Pls enter a valid name";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  return null;
                                }),
                          ),
                        ),
                        //  last name
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, right: 5),
                            child: MyTextField(
                                controller: lastName,
                                hintText: 'Last Name',
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Last Name is Required";
                                  }
                                  if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                                    return "Pls enter a valid name";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  return null;
                                }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // Basic monthly salary field

                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Basic monthly salary'),
                        Text('Housing Transport and \n other allowance')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: MyTextField(
                                controller: salary,
                                hintText: 'enter amount',
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Amount is Required";
                                  }
                                  if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                                    return "Pls enter a valid amount";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  basicMS = double.parse(value!);

                                  return null;
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: MyTextField(
                                controller: allowance,
                                hintText: 'enter amount',
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Amount is Required";
                                  }
                                  if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                                    return "Pls enter a valid amount";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  hTOA = double.parse(value!);

                                  return null;
                                }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // pension Administrators

                    const Text('Pension Administrator'),
                    MyTextField(
                        controller: administrator,
                        hintText: 'enter name of administrator',
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name of pension administrator required is Required";
                          }
                          if (!RegExp(r"^[a-zA-Z]+(?:\s[a-zA-Z]+)*$")
                              .hasMatch(value)) {
                            return "Pls enter a valid name";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          return null;
                        }),

                    // Employee contribution and employer contribution
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Employee contribution'),
                          Text('employer contribution')
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: MyTextField(
                                controller: employeeContribution,
                                hintText: 'enter percentage',
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Amount is Required";
                                  }
                                  if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                                    return "Pls enter a valid number from 0-100";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  employeeCont = double.parse(value!);
                                  return null;
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: MyTextField(
                                controller: employerContribution,
                                hintText: 'enter percentage',
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Amount is Required";
                                  }
                                  if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                                    return "Pls enter a valid number from 0-100";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  employerCont = double.parse(value!);
                                  return null;
                                }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    MyButton(
                        onTap: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          } else {
                            formKey.currentState!.save();
                            pensionCalculator();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => PensionInfoPage())));
                          }
                          print('first name: ' + firstName.text);
                          print('last name: ' + lastName.text);
                          print('bms: ' + basicMS.toString());
                          print('htoa' + hTOA.toString());
                          print('employee cont' + employeeCont.toString());
                          print('employer cont' + employerCont.toString());
                          print('employee Pen cont' +
                              employeePenContr.toString());
                          print('employer pen cont' +
                              employeePenContr.toString());
                          print('total pen cont' + totalPenContr.toString());
                        },
                        text: 'Submit'),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
