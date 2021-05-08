import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/models/Faculty.dart';
import 'package:unihub_app/models/degree.dart';
import 'package:unihub_app/models/university.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/screens/login/login.dart';
import 'package:chips_choice/chips_choice.dart';

String finalUsername;
UserApp currentUser;
List<University> universitiesList = [];
List<Faculty> schoolsList = [];
List<Degree> degreesList = [];
List<String> subjectsList = [];
List<String> universitiesNamesList = [];
List<String> schoolsNamesList = [];
List<String> degreesNamesList = [];

class EditProfileScreen extends StatefulWidget {
  EditProfile createState() => EditProfile();
}

class EditProfile extends State<EditProfileScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      currentUser = UserApp.fromMap(
          jsonDecode(await EditProfileController().getProfile(finalUsername)));
      getUniversities();
      _nameController.text = currentUser.fullname;
      _descriptionController.text = currentUser.description;
      _universityController.text = currentUser.university;
      _degreeController.text = currentUser.degree;
      _roleController.text = currentUser.role;
      _subjectsdoneController.text = currentUser.subjectsDone;
      _subjectsaskingController.text = currentUser.subjectsRequested;
      _passwordController.text = currentUser.password;
      _phoneController.text = currentUser.phone;
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;

  Future getValidationData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var username = preferences.getString('username');
    setState(() {
      finalUsername = username;
    });
  }

  Future getUniversities() async {
    universitiesList = [];
    universitiesNamesList = [];
    schoolsNamesList = [];
    degreesList = [];
    degreesNamesList = [];
    subjectsList = [];
    http.Response response = await EditProfileController().getUniversities();
    for (var university in jsonDecode(response.body)) {
      universitiesList.add(University.fromMap(university));
      universitiesNamesList.add(University.fromMap(university).name);
      print(universitiesNamesList);
    }
  }

  Future getSchools(String uniName) async {
    schoolsNamesList = [];
    degreesList = [];
    degreesNamesList = [];
    subjectsList = [];
    for (var university in universitiesList) {
      if (university.name == uniName) {
        schoolsNamesList = new List<String>.from(university.schools);
      }
    }
    print(schoolsNamesList);
  }

  Future<List<String>> getDegrees(String schoolParam) async {
    degreesList = [];
    degreesNamesList = [];
    subjectsList = [];
    http.Response response =
        await EditProfileController().getSchool(schoolParam);
    Faculty school = Faculty.fromMap(jsonDecode(response.body));
    degreesNamesList = new List<String>.from(school.degrees);
    print(degreesNamesList);
    return degreesNamesList;
  }

  Future<List<String>> getSubjects(String degreeParam) async {
    subjectsList = [];
    http.Response response =
        await EditProfileController().getDegree(degreeParam);
    Degree degree = Degree.fromMap(jsonDecode(response.body));
    subjectsList = new List<String>.from(degree.subjects);
    print(subjectsList);
    return subjectsList;
  }

  //Campos que ya está rellenos autocompletar!
  //Universidad, grado, rol, asignaturas (hechas y solicitadas) son dropdown menus!
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _subjectsdoneController = TextEditingController();
  final TextEditingController _subjectsaskingController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  String universitySelected;
  String schoolSelected;
  String degreeSelected;
  List<String> subjectsAskingSelected;
  List<String> subjectsDoneSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(10),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 4,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: Offset(0, 2))
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg"))),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 4,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                              color: Colors.blue),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Full Name",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  controller: _descriptionController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Description",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Phone",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                              ),
                              Container(
                                child: new DropdownButton<String>(
                                  isExpanded: true,
                                  value: universitySelected,
                                  hint: Text('University'),
                                  items: universitiesNamesList.map((String e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  onChanged: (String e) {
                                    setState(() {
                                      universitySelected = e;
                                    });
                                    getSchools(e);
                                  },
                                ),
                              ),
                              Container(
                                child: new DropdownButton<String>(
                                  isExpanded: true,
                                  value: schoolSelected,
                                  hint: Text('School'),
                                  items: schoolsNamesList.map((String e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  onChanged: (String e) async {
                                    setState(() {
                                      schoolSelected = e;
                                    });
                                  },
                                ),
                              ),
                              FutureBuilder<List<String>>(
                                  future: getDegrees(schoolSelected),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        child: new DropdownButton<String>(
                                          isExpanded: true,
                                          value: degreeSelected,
                                          hint: Text('Degree'),
                                          items: snapshot.data.map((String e) {
                                            return DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            );
                                          }).toList(),
                                          onChanged: (String e) async {
                                            setState(() {
                                              degreeSelected = e;
                                            });
                                          },
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  controller: _roleController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Role",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                              ),
                              FutureBuilder<List<String>>(
                                future: getSubjects(degreeSelected),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        child: Column(children: [
                                      Text('Subjects asking for'),
                                      ChipsChoice<String>.multiple(
                                          wrapped: false,
                                          value: subjectsAskingSelected,
                                          onChanged: (val) => setState(() =>
                                              subjectsAskingSelected = val),
                                          choiceItems:
                                              C2Choice.listFrom<String, String>(
                                                  source: subjectsList,
                                                  value: (i, v) => v,
                                                  label: (i, v) => v)),
                                    ]));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  controller: _subjectsdoneController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Subjects already done",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  controller: _subjectsaskingController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Subjects asking for",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  obscureText: _isHidden,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: 'Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    suffix: InkWell(
                                      onTap: _tooglePasswordView,
                                      child: Icon(
                                        _isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  obscureText: _isHidden,
                                  controller: _password2Controller,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Missing confirmation of the password';
                                    }
                                    if (_passwordController.text != (value)) {
                                      return 'Passwords are not equal. Please enter the same password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: 'Repeat Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    suffix: InkWell(
                                      onTap: _tooglePasswordView,
                                      child: Icon(
                                        _isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(140, 40)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(140, 40)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        UserApp updatedUser = new UserApp(
                                          currentUser.username,
                                          _passwordController.text,
                                          _nameController.text,
                                          _descriptionController.text,
                                          _universityController.text,
                                          _degreeController.text,
                                          _roleController.text,
                                          _subjectsdoneController.text,
                                          _subjectsaskingController.text,
                                          _phoneController.text,
                                        );
                                        http.Response response =
                                            await EditProfileController()
                                                .updateProfile(updatedUser);
                                        if (response.statusCode == 200) {
                                          createToast("User correctly updated",
                                              Colors.green);
                                          Navigator.of(context).pop();
                                        } else {
                                          createToast(
                                              response.body, Colors.red);
                                        }
                                      }
                                    },
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                              )
                            ],
                          ),
                        ),
                      ),
                    )))));
  }

  void _tooglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
