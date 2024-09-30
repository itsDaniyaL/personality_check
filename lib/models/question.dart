class Question {
  final String title;
  final List<String> options;
  int selectedOption;

  Question(
      {required this.title, required this.options, this.selectedOption = -1});
}
