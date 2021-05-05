class FeedPublication {
  final String username;
  final DateTime publicationDate;
  final String content;
  final List<String> comments;
  final List<String> likes;

  FeedPublication(
    this.username,
    this.publicationDate,
    this.content,
    this.comments,
    this.likes,
  );

  factory FeedPublication.fromMap(Map<String, dynamic> json) {
    return FeedPublication(
      json['username'],
      json['publicationDate'],
      json['content'],
      json['comments'],
      json['likes'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      'username': this.username,
      'publicationDate': this.publicationDate,
      'content': this.content,
      'comments': this.comments,
      'likes': this.likes,
    };
    return newJSON;
  }
}
