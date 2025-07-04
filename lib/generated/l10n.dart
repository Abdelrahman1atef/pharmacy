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

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
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

  /// `More`
  String get more_item {
    return Intl.message('More', name: 'more_item', desc: '', args: []);
  }

  /// `Profile`
  String get user_item {
    return Intl.message('Profile', name: 'user_item', desc: '', args: []);
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

  /// `Your Account`
  String get yourAccount {
    return Intl.message(
      'Your Account',
      name: 'yourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get myProfile {
    return Intl.message('Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message('My Orders', name: 'myOrders', desc: '', args: []);
  }

  /// `Admin Screen`
  String get adminScreen {
    return Intl.message(
      'Admin Screen',
      name: 'adminScreen',
      desc: '',
      args: [],
    );
  }

  /// `You are not logged in`
  String get notLoggedIn {
    return Intl.message(
      'You are not logged in',
      name: 'notLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Login or Sign up`
  String get LoginOrSignUp {
    return Intl.message(
      'Login or Sign up',
      name: 'LoginOrSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Account Details`
  String get accountDetails {
    return Intl.message(
      'Account Details',
      name: 'accountDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get confirmLogoutTitle {
    return Intl.message(
      'Confirm Logout',
      name: 'confirmLogoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get confirmLogoutContent {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'confirmLogoutContent',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Reorder`
  String get reorder {
    return Intl.message('Reorder', name: 'reorder', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Pending`
  String get orderStatusPending {
    return Intl.message(
      'Pending',
      name: 'orderStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Preparing`
  String get orderStatusPreparing {
    return Intl.message(
      'Preparing',
      name: 'orderStatusPreparing',
      desc: '',
      args: [],
    );
  }

  /// `Shipped`
  String get orderStatusShipped {
    return Intl.message(
      'Shipped',
      name: 'orderStatusShipped',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get orderStatusDelivered {
    return Intl.message(
      'Delivered',
      name: 'orderStatusDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get orderStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'orderStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Undefined`
  String get orderStatusUndefined {
    return Intl.message(
      'Undefined',
      name: 'orderStatusUndefined',
      desc: '',
      args: [],
    );
  }

  /// `Order #`
  String get orderNum {
    return Intl.message('Order #', name: 'orderNum', desc: '', args: []);
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get orderDetailsAddress {
    return Intl.message(
      'Delivery Address',
      name: 'orderDetailsAddress',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get orderDetailsPayment {
    return Intl.message(
      'Payment',
      name: 'orderDetailsPayment',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fees`
  String get deliveryFees {
    return Intl.message(
      'Delivery Fees',
      name: 'deliveryFees',
      desc: '',
      args: [],
    );
  }

  /// `Additional fees may apply for long distances`
  String get longDistanceFees {
    return Intl.message(
      'Additional fees may apply for long distances',
      name: 'longDistanceFees',
      desc: '',
      args: [],
    );
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

  /// `Go To Cart`
  String get goToCart {
    return Intl.message('Go To Cart', name: 'goToCart', desc: '', args: []);
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

  /// `Proceed To Checkout`
  String get proceedToCheckout {
    return Intl.message(
      'Proceed To Checkout',
      name: 'proceedToCheckout',
      desc: '',
      args: [],
    );
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

  /// `Home Delivery`
  String get homeDelivery {
    return Intl.message(
      'Home Delivery',
      name: 'homeDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy Pickup`
  String get pharmacyPickup {
    return Intl.message(
      'Pharmacy Pickup',
      name: 'pharmacyPickup',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Change Delivery Time`
  String get changeTimeDeliver {
    return Intl.message(
      'Change Delivery Time',
      name: 'changeTimeDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Change Pickup Time`
  String get changeTimePickup {
    return Intl.message(
      'Change Pickup Time',
      name: 'changeTimePickup',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy`
  String get pharmacy {
    return Intl.message('Pharmacy', name: 'pharmacy', desc: '', args: []);
  }

  /// `Open Now`
  String get openNow {
    return Intl.message('Open Now', name: 'openNow', desc: '', args: []);
  }

  /// `Close Now`
  String get closeNow {
    return Intl.message('Close Now', name: 'closeNow', desc: '', args: []);
  }

  /// `Delivery`
  String get delivery {
    return Intl.message('Delivery', name: 'delivery', desc: '', args: []);
  }

  /// `Pickup`
  String get pickup {
    return Intl.message('Pickup', name: 'pickup', desc: '', args: []);
  }

  /// `Request a Call To Confirm The Order`
  String get requestACallToConfirmTheOrder {
    return Intl.message(
      'Request a Call To Confirm The Order',
      name: 'requestACallToConfirmTheOrder',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optional {
    return Intl.message('Optional', name: 'optional', desc: '', args: []);
  }

  /// `Cash On Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash On Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Debit/Credit Card`
  String get debitCreditCard {
    return Intl.message(
      'Debit/Credit Card',
      name: 'debitCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Debit/Credit Card upon receipt`
  String get debitCreditCardUponReceipt {
    return Intl.message(
      'Debit/Credit Card upon receipt',
      name: 'debitCreditCardUponReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Your Discount`
  String get yourDiscount {
    return Intl.message(
      'Your Discount',
      name: 'yourDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Add Promo Code`
  String get addPromoCode {
    return Intl.message(
      'Add Promo Code',
      name: 'addPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Select Delivery Time`
  String get selectDeliveryTime {
    return Intl.message(
      'Select Delivery Time',
      name: 'selectDeliveryTime',
      desc: '',
      args: [],
    );
  }

  /// `Select Pickup Time`
  String get selectPickupTime {
    return Intl.message(
      'Select Pickup Time',
      name: 'selectPickupTime',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message('Select Time', name: 'selectTime', desc: '', args: []);
  }

  /// `Selected Date & Time`
  String get selectedDateTime {
    return Intl.message(
      'Selected Date & Time',
      name: 'selectedDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `processing Order`
  String get processingOrder {
    return Intl.message(
      'processing Order',
      name: 'processingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order #`
  String get OrderNum {
    return Intl.message('Order #', name: 'OrderNum', desc: '', args: []);
  }

  /// `Created At`
  String get CreatedAt {
    return Intl.message('Created At', name: 'CreatedAt', desc: '', args: []);
  }

  /// `Customer Id`
  String get CustomerId {
    return Intl.message('Customer Id', name: 'CustomerId', desc: '', args: []);
  }

  /// `Customer Name`
  String get CustomerName {
    return Intl.message(
      'Customer Name',
      name: 'CustomerName',
      desc: '',
      args: [],
    );
  }

  /// `Customer Email`
  String get CustomerEmail {
    return Intl.message(
      'Customer Email',
      name: 'CustomerEmail',
      desc: '',
      args: [],
    );
  }

  /// `Customer Phone`
  String get CustomerPhone {
    return Intl.message(
      'Customer Phone',
      name: 'CustomerPhone',
      desc: '',
      args: [],
    );
  }

  /// `product Id`
  String get productId {
    return Intl.message('product Id', name: 'productId', desc: '', args: []);
  }

  /// `name Ar`
  String get nameAr {
    return Intl.message('name Ar', name: 'nameAr', desc: '', args: []);
  }

  /// `name En`
  String get nameEn {
    return Intl.message('name En', name: 'nameEn', desc: '', args: []);
  }

  /// `unit Type`
  String get unitType {
    return Intl.message('unit Type', name: 'unitType', desc: '', args: []);
  }

  /// `quantity`
  String get quantity {
    return Intl.message('quantity', name: 'quantity', desc: '', args: []);
  }

  /// `itemTotal`
  String get itemTotal {
    return Intl.message('itemTotal', name: 'itemTotal', desc: '', args: []);
  }

  /// `Best seller`
  String get best_seller {
    return Intl.message('Best seller', name: 'best_seller', desc: '', args: []);
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
