import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/pages/Cubits/login_cubit/login_cubit.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/register_page.dart';
import 'package:my_chat_app/widgets/custom_button.dart';
import 'package:my_chat_app/widgets/custom_email_text_field.dart';
import 'package:my_chat_app/widgets/custom_password_text_field.dart';
import '../const.dart';
import '../helper/show_snack_bar.dart';

class LogInPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  static String id = 'LogInPage';

  bool isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 75),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
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
                        'Log In',
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
                  CustomPasswordFormTextField(
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).loginUser(
                          email: email!,
                          password: password!,
                        );
                      } else {}
                    },
                    text: 'LOG IN',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          '   Register',
                          style:
                              TextStyle(color: Color(0xffd1f4f4), fontSize: 16),
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
      ),
    );
  }
}
