import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/login&signup/logic/login/login_cubit.dart';
import 'package:pharmacy/features/login&signup/ui/widgets/login_signup_app_bar.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:pharmacy/generated/l10n.dart'; // <-- import your localization file

import '../../logic/login/login_state.dart';
import '../widgets/toggle_buttons.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final loginOption = [s.login_phone, s.login_email];

    return Scaffold(
      appBar: const LoginSignUpAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [MyToggleButtons(loginOption: loginOption)],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email or Phone
                  BlocBuilder<LoginScreenCubit, LoginScreenState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: _emailPhoneController,
                        autofocus: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return state.isPhoneSelected
                                ? s.login_phone_hint
                                : s.login_email_hint;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: state.isPhoneSelected
                              ? s.login_phone_hint
                              : s.login_email_hint,
                          hintStyle: TextStyles.loginSignupText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),

                  // Password
                  BlocBuilder<LoginScreenCubit, LoginScreenState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: !state.isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return s
                                .login_password; // You may add a new string key like `invalid_password`
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: s.login_password,
                          hintStyle: TextStyles.loginSignupText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context
                                  .read<LoginScreenCubit>()
                                  .setPasswordVisible(!state.isPasswordVisible);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        s.login_forgot_password,
                        style: TextStyles.loginSignupText.copyWith(
                          color: ColorName.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login button
                  GradientElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final emailOrPhone = _emailPhoneController.text;
                        final password = _passwordController.text;

                        // Simulate incorrect credentials
                        if (emailOrPhone != "test" || password != "123456") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid credentials"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          print("""
                          ${_emailPhoneController.text}
                          ${_passwordController.text}
                          """);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Login success!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      s.login_button,
                      style: TextStyles.gradientElevatedButtonText,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: Text(
                      s.login_social_text,
                      style: TextStyles.loginSignupText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),

                  _socialButton(
                    label: s.login_google,
                    icon: Assets.images.google.svg(),
                    onPressed: () => _googleLogin(),
                  ),
                  const SizedBox(height: 10),

                  _socialButton(
                    label: s.login_facebook,
                    icon: Assets.images.facebook.svg(),
                    onPressed: () {
                      _googleSignIn.signOut();
                    },
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: Text(
                      s.login_no_account,
                      style: TextStyles.loginSignupText,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _socialButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.signUp);
                    },
                    label: s.login_new_user,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required String label,
    SvgPicture? icon,
    required VoidCallback onPressed,
  }) {
    return GradientElevatedButton(
      onPressed: onPressed,
      gradientColors: const [ColorName.whiteColor, Color(0xFFBBDEFB)],
      haveBorder: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
              child: SizedBox(width: 24, height: 24, child: icon),
            ),
          Text(
            label,
            style: TextStyles.loginSignupText.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorName.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _googleLogin() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      if (googleSignInAccount != null) {
        print("""
     id: ${googleSignInAccount.id}
     email: ${googleSignInAccount.email}
     photoUrl: ${googleSignInAccount.photoUrl}
     displayName: ${googleSignInAccount.displayName}
     serverAuthCode: ${googleSignInAccount.serverAuthCode}
     accessToken: ${googleSignInAuthentication?.accessToken}
      """);
      } else {
        const SnackBar(
          content: Text("Sign in Failed"),
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      print(error);
    }
  }
}
