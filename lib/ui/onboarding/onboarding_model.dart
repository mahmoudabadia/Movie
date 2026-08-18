class OnboardingModel {
   String imagePath;
   String title;
   String? description;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    this.description,
  });
}