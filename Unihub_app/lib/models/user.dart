class UserApp {
  final String username;
  final String password;
  final String fullname;
  final String phone;
  final String profilePhoto;

  UserApp(this.username, this.fullname, this.password, this.phone, this.profilePhoto);

  factory UserApp.fromMap(Map<String, dynamic> json) {
    return UserApp(
      json['username'],
      json['fullname'],
      json['password'],
      json['phone'],
      json['profilePhoto'],
    );
  }
}