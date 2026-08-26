import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(Locale('en'));

  void changeLanguage(String newLnaguage) {
    emit(Locale(newLnaguage));
  }

  void toggleLanguage() {
    if (state.languageCode == 'en') {
      emit(Locale('ar'));
    } else {
      emit(Locale('en'));
    }
  }
}
