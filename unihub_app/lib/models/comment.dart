class Comment {
  final String id;
  final String feedId;
  final String username;
  final DateTime publicationDate;
  final String content;

  Comment(
    this.id,
    this.feedId,
    this.username,
    this.publicationDate,
    this.content,
  );

  factory Comment.fromMap(Map<String, dynamic> json) {
    return Comment(
      json['_id'],
      json['feedId'],
      json['username'],
      DateTime.parse(json['publicationDate']),
      json['content'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      "feedId": this.feedId,
      'username': this.username,
      'publicationDate': this.publicationDate,
      'content': this.content,
    };
    return newJSON;
  }
}
