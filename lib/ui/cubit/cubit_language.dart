import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  static const String languageKey = 'selectedLanguage';

  LanguageCubit() : super(const Locale('en')) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLangCode = prefs.getString(languageKey) ?? 'en';
    emit(Locale(savedLangCode));
  }

  Future<void> changeLanguage(String newLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, newLanguage);
    emit(Locale(newLanguage));
  }

  Future<void> toggleLanguage() async {
    final newLangCode = state.languageCode == 'en' ? 'ar' : 'en';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, newLangCode);
    emit(Locale(newLangCode));
  }
}