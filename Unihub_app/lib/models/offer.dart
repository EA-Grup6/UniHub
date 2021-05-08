class OfferApp {
  final String username;
  final String title;
  final String university;
  final String subject;
  final String type;
  final String description;
  final String price;
  final List<String> comments;
  final List<String> likes;

  OfferApp(
    this.title,
    this.username,
    this.university,
    this.subject,
    this.type,
    this.description,
    this.price,
    this.comments,
    this.likes,
  );

  factory OfferApp.fromMap(Map<String, dynamic> json) {
    return OfferApp(
      json['username'],
      json['title'],
      json['university'],
      json['subject'],
      json['type'],
      json['description'],
      json['price'],
      json['comments'],
      json['likes'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      'username': this.username,
      'title': this.title,
      'university': this.university,
      'subject': this.subject,
      'type': this.type,
      'description': this.description,
      'price': this.price,
      'comments': this.comments,
      'likes': this.likes,
    };
    return newJSON;
  }
}