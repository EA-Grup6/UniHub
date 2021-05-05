import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/models/user.dart';

String finalUsername;
UserApp currentUser;

class EditingProfileScreen extends StatefulWidget {
  EditingProfile createState() => EditingProfile();
}

class EditingProfile extends State<EditingProfileScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      currentUser = UserApp.fromMap(
          jsonDecode(await EditProfileController().getProfile(finalUsername)));
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
        body: Container(
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
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                  contentPadding: EdgeInsets.only(bottom: 3),
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
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  labelText: "Description",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  labelText: "Phone",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: TextFormField(
                              controller: _universityController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  labelText: "University",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: TextFormField(
                              controller: _degreeController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  labelText: "Degree",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: TextFormField(
                              controller: _roleController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  labelText: "Role",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: TextFormField(
                              controller: _subjectsdoneController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
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
                                  contentPadding: EdgeInsets.only(bottom: 3),
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
                                  minimumSize: MaterialStateProperty.all<Size>(
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
                                  minimumSize: MaterialStateProperty.all<Size>(
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
                                    EditProfileController()
                                        .updateProfile(updatedUser);
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  void _tooglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
