class User {
  String username;
  String password;
  String fullname;
  String phone;
  String profilePhoto;

  User(this.username, this.fullname, this.password, this.phone,
      this.profilePhoto);

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      json['username'],
      json['fullname'],
      json['password'],
      json['phone'],
      json['profilePhoto'],
    );
  }
}
