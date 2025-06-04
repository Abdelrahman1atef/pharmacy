// ... imports remain unchanged

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/models/register_login/login_request.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/login&signup/logic/signup/signup_cubit.dart';
import 'package:pharmacy/features/login&signup/logic/signup/signup_state.dart';
import 'package:pharmacy/gen/colors.gen.dart';

import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../core/models/register_login/register_request.dart';
import '../../../../generated/l10n.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();

  bool agree = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  String selectedGender = S.current.gender;
  DateTime? selectedDate;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PharmacyAppBar(
        heightFactor: 1.1,
         isGeneralLayout: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Text(S.of(context).signup,
                            style: TextStyles.loginSignupText
                                .copyWith(fontSize: 27)),
                      ),
                      const SizedBox(height: 20),
                      _buildNameInput(
                          S.of(context).first_name, _firstNameController),
                      _buildNameInput(
                          S.of(context).last_name, _lastNameController),
                      _buildEmailInput(S.of(context).email, _emailController),
                      _buildPhoneInput(S.of(context).phone, _phoneController),
                      _buildDropdown(),
                      _buildDatePicker(dateController),
                      _buildPasswordInput(
                          S.of(context).create_password, _passwordController,
                          isConfirm: false),
                      _buildConfirmPasswordInput(S.of(context).confirm_password,
                          _confirmPasswordController, _passwordController,
                          isConfirm: true),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: agree,
                            onChanged: (value) {
                              setState(() => agree = value!);
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              text: S.of(context).agree_terms,
                              children: [
                                TextSpan(
                                  text: S.of(context).terms,
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 30),
                  child: BlocListener<SignupCubit, SignupState>(
                    listener: (context, state) {
                      state.when(
                        loading: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                                child: CircularProgressIndicator()),
                          );
                        },
                        success: (data) {
                          LoginRequest loginBody = LoginRequest(
                              email: _emailController.text,
                              password: _passwordController.text);
                          context.read<AuthCubit>().login(loginBody);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // Handle success (e.g., show success message or navigate)
                        },
                        error: (e) async{
                          Navigator.pop(context);
                          final shouldLogout = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirm Login"),
                              content:  Text(e.message),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                          if (shouldLogout == true) {

                          }
                        },
                        initial: () {},
                      );
                    },
                    child: GradientElevatedButton(
                      onPressed: !agree
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final registerRequest = RegisterRequest(

                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  birthdate: dateController.text,
                                  gender: selectedGender,
                                  password: _passwordController.text,
                                  profilePicture: "",
                                  // Assuming no profile picture for now
                                  isActive: true,
                                  // Default value for isActive
                                  isStaff: false, // Default value for isStaff
                                );
                                context
                                    .read<SignupCubit>()
                                    .emitUserRegister(registerRequest);
                              }
                            },
                      haveBorder: true,
                      gradientColors: const [
                        ColorName.whiteColor,
                        Color(0xFFBBDEFB)
                      ],
                      child: Text(S.of(context).continue_,
                          style: TextStyles.loginSignupText.copyWith(
                              color: ColorName.secondaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 20),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                      child: Text(
                        S.of(context).already_have_account,
                        style: TextStyles.loginSignupText.copyWith(
                          color: ColorName.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return S.of(context).enter_name;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          labelText: hint,
          hintStyle: TextStyles.loginSignupText,
          labelStyle: TextStyles.loginSignupText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildEmailInput(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.of(context).enter_email;
          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
              .hasMatch(value)) {
            return S.of(context).invalid_email;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          labelText: hint,
          hintStyle: TextStyles.loginSignupText,
          labelStyle: TextStyles.loginSignupText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildPhoneInput(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  value: "+20",
                  items: ["+20"]
                      .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 6,
                child: TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  controller: controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).enter_phone;
                    } else if (value.length < 10) {
                      return S.of(context).invalid_phone;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: hint,
                    hintText: hint,
                    hintStyle: TextStyles.loginSignupText,
                    labelStyle: TextStyles.loginSignupText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
          Text(S.of(context).send_sms_verification),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedGender != S.of(context).gender ? selectedGender : null,
        hint: Text(S.of(context).gender),
        items: [
          S.of(context).male,
          S.of(context).female,
        ]
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {
          setState(() => selectedGender = value!);
        },
        validator: (value) {
          if (value == null) return S.of(context).select_gender;
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildDatePicker(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.of(context).select_birthdate;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: S.of(context).birthdate,
          hintStyle: TextStyles.loginSignupText,
          labelStyle: TextStyles.loginSignupText,
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            setState(() {
              selectedDate = picked;
              controller.text = DateFormat('yyyy-MM-dd').format(picked);
            });
          }
        },
      ),
    );
  }

  Widget _buildPasswordInput(String hint, TextEditingController controller,
      {required bool isConfirm}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isConfirm ? !showConfirmPassword : !showPassword,
        validator: (value) {
          if (value == null || value.length < 6) {
            return S.of(context).password_short;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: hint,
          hintText: hint,
          hintStyle: TextStyles.loginSignupText,
          labelStyle: TextStyles.loginSignupText,
          suffixIcon: IconButton(
            icon: Icon((isConfirm ? showConfirmPassword : showPassword)
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              setState(() {
                if (isConfirm) {
                  showConfirmPassword = !showConfirmPassword;
                } else {
                  showPassword = !showPassword;
                }
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordInput(
      String hint,
      TextEditingController confirmController,
      TextEditingController passwordController,
      {required bool isConfirm}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: confirmController,
        obscureText: isConfirm ? !showConfirmPassword : !showPassword,
        validator: (value) {
          if (value != passwordController.text) {
            return S.of(context).password_mismatch;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: hint,
          hintText: hint,
          hintStyle: TextStyles.loginSignupText,
          labelStyle: TextStyles.loginSignupText,
          suffixIcon: IconButton(
            icon: Icon((isConfirm ? showConfirmPassword : showPassword)
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              setState(() {
                if (isConfirm) {
                  showConfirmPassword = !showConfirmPassword;
                } else {
                  showPassword = !showPassword;
                }
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
