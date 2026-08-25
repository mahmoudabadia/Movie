import 'package:flutter/material.dart';
class OnboardingModel {
   String imagePath;
   String title;
   String? description;
   final Gradient gradient;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    this.description,
   required this.gradient
  });
}