class Question {
  final String title;
  final Map<String, String> options;
  int? selectedOption;

  Question({
    required this.title,
    required this.options,
    this.selectedOption,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'options': options,
      'selectedOption': selectedOption,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      title: json['title'],
      options: Map<String, String>.from(json['options']),
      selectedOption: json['selectedOption'],
    );
  }
}
