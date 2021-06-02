class Faqs {
  final String question;
  final String answer;

  Faqs(
    this.question,
    this.answer,
  );

  factory Faqs.fromMap(Map<String, dynamic> json) {
    return Faqs(
      json['question'],
      json['answer'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      'question': this.question,
      'answer': this.answer,
    };
    return newJSON;
  }
}