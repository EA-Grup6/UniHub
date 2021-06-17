class Comment {
  final String id;
  final String feedId;
  final String username;
  final DateTime publicationDate;
  final String content;
  final List<dynamic> likes;

  Comment(
    this.id,
    this.feedId,
    this.username,
    this.publicationDate,
    this.content,
    this.likes,
  );

  factory Comment.fromMap(Map<String, dynamic> json) {
    return Comment(
        json['_id'],
        json['feedId'],
        json['username'],
        DateTime.parse(json['publicationDate']),
        json['content'],
        json['likes']);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      'username': this.username,
      'publicationDate': this.publicationDate,
      'content': this.content,
      'likes': this.likes
    };
    return newJSON;
  }
}
