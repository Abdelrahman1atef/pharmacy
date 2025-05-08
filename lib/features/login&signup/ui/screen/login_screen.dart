
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/core/models/register_login/login_request.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/login&signup/logic/login/login_cubit.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:pharmacy/generated/l10n.dart'; // <-- import your localization file

import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../../../core/common_widgets/pharmacy_app_bar.dart';
import '../../logic/login/login_state.dart';
import '../widgets/toggle_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailPhoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailPhoneFocusNode = FocusNode();

  @override
  void dispose() {
    _emailPhoneController.dispose();
    _passwordController.dispose();
    _emailPhoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final loginOption = [s.login_phone, s.login_email];

    return Scaffold(
      appBar:  const PharmacyAppBar(
        isGeneralLayout: false,
        heightFactor: 1.1,
      ),
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
                      children: [
                        MyToggleButtons(
                          loginOption: loginOption,
                          emailPhoneFocusNode: _emailPhoneFocusNode,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email or Phone
                  BlocBuilder<LoginScreenCubit, LoginScreenState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: _emailPhoneController,
                        focusNode: _emailPhoneFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return state.isPhoneSelected
                                ? s.login_phone_hint
                                : s.login_email_hint;
                          }
                          return null;
                        },
                        keyboardType: state.isPhoneSelected
                            ? TextInputType.phone
                            : TextInputType.emailAddress,
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
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    state.when(
                      initial: () {}, // No side effect needed
                      loading: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(child: CircularProgressIndicator()),
                        );
                      },
                      authenticated: (user) {
                         Navigator.pop(context); // Close loading dialog
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context); // Close signup screen
                        }); // Close login screen
                      },
                      unauthenticated: (message) async{
                        Navigator.pop(context);
                        final shouldLogout = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Confirm Login"),
                            content:  Text(message!),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                        if (shouldLogout == true) {
                           _emailPhoneController.clear();
                           _passwordController.clear();
                        }
                      },
                    );
                  },
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );

                    return GradientElevatedButton(
                      onPressed: isLoading
                          ? null // Disable while loading
                          : () {
                        if (_formKey.currentState!.validate()) {
                          final emailOrPhone = _emailPhoneController.text.trim();
                          final password = _passwordController.text;

                          final isEmail = emailOrPhone.contains('@');

                          final loginRequest = LoginRequest(
                            email: isEmail ? emailOrPhone : null,
                            phone: isEmail ? null : emailOrPhone,
                            password: password,
                          );

                          context.read<AuthCubit>().login(loginRequest);
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: isLoading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        s.login_button,
                        style: TextStyles.gradientElevatedButtonText,
                      ),
                    );
                  },
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
              child: SizedBox(width: 20, height: 24, child: icon),
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
