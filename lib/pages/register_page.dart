import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/my_button.dart';
import 'package:final_year_project/components/my_textfield.dart';
import 'package:final_year_project/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void signUserUp() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    // try creating the user

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorMessage(e.code);
    }
  }

  void errorMessage(String message) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text(message),
          );
        }));
  }

  String email = '';
  String password = '';
  String confirmPassword = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F9FD),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 15),
                  child: Text(
                    'Staff pension management system for Kaduna Polytechnic',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is Required";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Please enter a valid email address";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                ),

                const SizedBox(
                  height: 25,
                ),
                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is Required";
                    }
                    if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(value)) {
                      return "Password must contain one 'special character', 'Uppercase', 'Alphabet' and 'Number'";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                ),

                const SizedBox(
                  height: 25,
                ),

                // confirm password
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid password";
                    }
                    if (password != confirmPassword) {
                      return "Password does not match";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    confirmPassword = value!;
                  },
                ),

                const SizedBox(
                  height: 25,
                ),
                //sign in button

                MyButton(
                    onTap: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      } else {
                        signUserUp();
                      }
                      formKey.currentState!.save();

                      print('email: ' + email);
                      print('password: ' + password);
                      print('confirm: ' + confirmPassword);
                    },
                    text: 'Sign up'),

                const SizedBox(
                  height: 25,
                ),

                //Already have an account Login here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account?',
                      style: TextStyle(color: Colors.grey[700], fontSize: 15),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
