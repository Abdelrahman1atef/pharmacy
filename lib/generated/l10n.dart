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
