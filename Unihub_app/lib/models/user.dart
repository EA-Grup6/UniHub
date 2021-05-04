class UserApp {
  final String username;
  final String password;
  final String fullname;
  final String description;
  final String university;
  final String degree;
  final String role;
  final String subjectsDone;
  final String subjectsRequested;
  final String phone;
  String profilePhoto;

  UserApp(
      this.username,
      this.password,
      this.fullname,
      this.description,
      this.university,
      this.degree,
      this.role,
      this.subjectsDone,
      this.subjectsRequested,
      this.phone);

  factory UserApp.fromMap(Map<String, dynamic> json) {
    print(json['username']);
    return UserApp(
      json['username'],
      json['password'],
      json['fullname'],
      json['description'],
      json['university'],
      json['degree'],
      json['role'],
      json['subjectsDone'],
      json['subjectsRequested'],
      json['phone'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      'username': this.username,
      'password': this.password,
      'fullname': this.fullname,
      'description': this.description,
      'university': this.university,
      'degree': this.degree,
      'role': this.role,
      'subjectsDone': this.subjectsDone,
      'subjectsRequested': this.subjectsRequested,
      'phone': this.phone
    };
    return newJSON;
  }
}
