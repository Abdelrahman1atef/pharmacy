// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ramzy Pharmacy`
  String get app_name {
    return Intl.message('Ramzy Pharmacy', name: 'app_name', desc: '', args: []);
  }

  /// `App Language`
  String get appLang {
    return Intl.message('App Language', name: 'appLang', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `App Mode`
  String get appMode {
    return Intl.message('App Mode', name: 'appMode', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `We'll send a text message to verify this number`
  String get send_sms_verification {
    return Intl.message(
      'We\'ll send a text message to verify this number',
      name: 'send_sms_verification',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Birthdate`
  String get birthdate {
    return Intl.message('Birthdate', name: 'birthdate', desc: '', args: []);
  }

  /// `Create Password`
  String get create_password {
    return Intl.message(
      'Create Password',
      name: 'create_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the `
  String get agree_terms {
    return Intl.message(
      'I agree to the ',
      name: 'agree_terms',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_ {
    return Intl.message('Continue', name: 'continue_', desc: '', args: []);
  }

  /// `Please enter your name`
  String get enter_name {
    return Intl.message(
      'Please enter your name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get enter_email {
    return Intl.message(
      'Please enter your email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalid_email {
    return Intl.message(
      'Invalid email format',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get enter_phone {
    return Intl.message(
      'Please enter your phone number',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalid_phone {
    return Intl.message(
      'Invalid phone number',
      name: 'invalid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Please select gender`
  String get select_gender {
    return Intl.message(
      'Please select gender',
      name: 'select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Please select birthdate`
  String get select_birthdate {
    return Intl.message(
      'Please select birthdate',
      name: 'select_birthdate',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_short {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_short',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_mismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'password_mismatch',
      desc: '',
      args: [],
    );
  }

  /// `Already Have Account ?`
  String get already_have_account {
    return Intl.message(
      'Already Have Account ?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get login_phone {
    return Intl.message('Phone', name: 'login_phone', desc: '', args: []);
  }

  /// `Email`
  String get login_email {
    return Intl.message('Email', name: 'login_email', desc: '', args: []);
  }

  /// `Phone Number`
  String get login_phone_hint {
    return Intl.message(
      'Phone Number',
      name: 'login_phone_hint',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get login_email_hint {
    return Intl.message(
      'Email Address',
      name: 'login_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_password {
    return Intl.message('Password', name: 'login_password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get login_forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'login_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_button {
    return Intl.message('Login', name: 'login_button', desc: '', args: []);
  }

  /// `Login or Sign up using your social accounts`
  String get login_social_text {
    return Intl.message(
      'Login or Sign up using your social accounts',
      name: 'login_social_text',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get login_google {
    return Intl.message(
      'Sign in with Google',
      name: 'login_google',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get login_facebook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'login_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get login_no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'login_no_account',
      desc: '',
      args: [],
    );
  }

  /// `New User`
  String get login_new_user {
    return Intl.message('New User', name: 'login_new_user', desc: '', args: []);
  }

  /// `Good Morning`
  String get morning_welcome_message {
    return Intl.message(
      'Good Morning',
      name: 'morning_welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get evening_welcome_message {
    return Intl.message(
      'Good Evening',
      name: 'evening_welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `Search for medicine(English or Arabic)`
  String get search_for_medicine {
    return Intl.message(
      'Search for medicine(English or Arabic)',
      name: 'search_for_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_item {
    return Intl.message('Home', name: 'home_item', desc: '', args: []);
  }

  /// `Settings`
  String get settings_item {
    return Intl.message('Settings', name: 'settings_item', desc: '', args: []);
  }

  /// `Cart`
  String get cart_item {
    return Intl.message('Cart', name: 'cart_item', desc: '', args: []);
  }

  /// `Categories`
  String get titles_category {
    return Intl.message(
      'Categories',
      name: 'titles_category',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get show_all {
    return Intl.message('Show All', name: 'show_all', desc: '', args: []);
  }

  /// `Best seller`
  String get best_seller {
    return Intl.message('Best seller', name: 'best_seller', desc: '', args: []);
  }

  /// `EGP`
  String get pound {
    return Intl.message('EGP', name: 'pound', desc: '', args: []);
  }

  /// `in Stock`
  String get available {
    return Intl.message('in Stock', name: 'available', desc: '', args: []);
  }

  /// `out of Stock`
  String get unavailable {
    return Intl.message(
      'out of Stock',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Brand`
  String get brandName {
    return Intl.message('Brand', name: 'brandName', desc: '', args: []);
  }

  /// `Unit`
  String get unit {
    return Intl.message('Unit', name: 'unit', desc: '', args: []);
  }

  /// `Product Details:`
  String get productDescription {
    return Intl.message(
      'Product Details:',
      name: 'productDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get addToCart {
    return Intl.message('Add To Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `NO Item Add In Cart Until Now`
  String get noItemInCart {
    return Intl.message(
      'NO Item Add In Cart Until Now',
      name: 'noItemInCart',
      desc: '',
      args: [],
    );
  }

  /// `Brows Items`
  String get browsItem {
    return Intl.message('Brows Items', name: 'browsItem', desc: '', args: []);
  }

  /// `Are you sure you want to remove`
  String get deleteCartItemAlertP1 {
    return Intl.message(
      'Are you sure you want to remove',
      name: 'deleteCartItemAlertP1',
      desc: '',
      args: [],
    );
  }

  /// `from your shopping cart?`
  String get deleteCartItemAlertP2 {
    return Intl.message(
      'from your shopping cart?',
      name: 'deleteCartItemAlertP2',
      desc: '',
      args: [],
    );
  }

  /// `Remove Item`
  String get deleteCartItem {
    return Intl.message(
      'Remove Item',
      name: 'deleteCartItem',
      desc: '',
      args: [],
    );
  }

  /// `Keep Item`
  String get keepCartItem {
    return Intl.message('Keep Item', name: 'keepCartItem', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Product`
  String get product {
    return Intl.message('Product', name: 'product', desc: '', args: []);
  }

  /// `of Products`
  String get ofProducts {
    return Intl.message('of Products', name: 'ofProducts', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
