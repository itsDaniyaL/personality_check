class Question {
  final String title;
  final Map<String, String> options;
  int? selectedOption;

  Question({
    required this.title,
    required this.options,
    this.selectedOption,
  });
}
