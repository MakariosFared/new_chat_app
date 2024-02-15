import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/const.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_email_text_field.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset('assets/images/scholar.png', height: 100),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomEmailFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(height: 15),
                CustomEmailFormTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(height: 40),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'The password is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading = false;
                    } else {}
                  },
                  text: 'REGISTER',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '   LOGIN',
                        style: TextStyle(
                          color: Color(0xffd1f4f4),
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
