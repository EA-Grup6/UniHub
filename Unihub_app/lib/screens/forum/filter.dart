import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/models/faculty.dart';
import 'package:unihub_app/models/degree.dart';
import 'package:unihub_app/models/university.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/models/offer.dart';
import 'package:unihub_app/screens/homepage/homepage.dart';
import 'package:unihub_app/screens/login/login.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:unihub_app/controllers/offer_controller.dart';

String finalUsername;
UserApp currentUser;
List<University> universitiesList = [];
List<Faculty> schoolsList = [];
List<Degree> degreesList = [];
List<String> subjectsList = [];
List<String> universitiesNamesList = [];
List<String> schoolsNamesList = [];
List<String> degreesNamesList = [];

String valueTipo;
List listTipo = [
  "Class",
  "Assignment",
  "Training for an exam",
];

class FilterScreen extends StatefulWidget {
  Filter createState() => Filter();
}

createToast(String message, Color color) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

class Filter extends State<FilterScreen> {
  final _formKey = GlobalKey<FormState>();

Future<List<OfferApp>> getOfferSubject(OfferApp offer ) async {
    http.Response response = await OfferController().getOffers();
    List<OfferApp> preListOffers = [];
    for (var offer in jsonDecode(response.body)) {
      preListOffers.add(OfferApp.fromMap(offer));
      print(OfferApp.fromMap(offer));
    }
    return preListOffers;
  }


  @override
  void initState() {
    getValidationData().whenComplete(() async {
      await getUniversities();
    });
    super.initState();
  }

  String universitySelected;
  String schoolSelected;
  String degreeSelected;
  String subjectsSelected;

  String valueAsign;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Filter Offers",
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
                                child: Column(children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: new DropdownButton<String>(
                                      isExpanded: true,
                                      value: universitySelected,
                                      hint: Text('University'),
                                      items:
                                          universitiesNamesList.map((String e) {
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
                                  FutureBuilder<List<String>>(
                                      future: getSchools(universitySelected),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            child: new DropdownButton<String>(
                                              isExpanded: true,
                                              value: schoolSelected,
                                              hint: Text('School'),
                                              items:
                                                  snapshot.data.map((String e) {
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
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                  FutureBuilder<List<String>>(
                                      future: getDegrees(schoolSelected),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            child: new DropdownButton<String>(
                                              isExpanded: true,
                                              value: degreeSelected,
                                              hint: Text('Degree'),
                                              items:
                                                  snapshot.data.map((String e) {
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
                                  FutureBuilder<List<String>>(
                                      future: getSubjects(degreeSelected),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            child: new DropdownButton<String>(
                                              isExpanded: true,
                                              value: subjectsSelected,
                                              hint: Text('Subject'),
                                              items:
                                                  snapshot.data.map((String e) {
                                                return DropdownMenuItem<String>(
                                                  value: e,
                                                  child: Text(e),
                                                );
                                              }).toList(),
                                              onChanged: (String e) async {
                                                setState(() {
                                                  subjectsSelected = e;
                                                });
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Type:"),
                                          DropdownButton(
                                            value: valueTipo,
                                            onChanged: (newValue) {
                                              setState(() {
                                                valueTipo = newValue;
                                              });
                                            },
                                            items: listTipo.map((valueItem) {
                                              return DropdownMenuItem(
                                                value: valueItem,
                                                child: Text(valueItem),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      )),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    child: Text(
                                      'Filter',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    onPressed: () async {},
                                  )
                                ]))))))));
  }

  Future getValidationData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var username = preferences.getString('username');
    setState(() {
      finalUsername = username;
    });
    currentUser = ModalRoute.of(this.context).settings.arguments as UserApp;

    currentUser.university == null
        ? universitySelected = currentUser.university
        : universitySelected = 'Not Selected';
  }

  Future<List<String>> getUniversities() async {
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
    }
    print(universitiesNamesList);
    universitiesNamesList.add('Not Selected');
    if (universitySelected != 'Not Selected' || universitySelected != null) {
      getSchools(universitySelected);
      if (schoolSelected != null || schoolSelected != 'Not Selected') {
        getDegrees(schoolSelected);
        if (degreeSelected != null || degreeSelected != 'Not Selected') {
          getSubjects(degreeSelected);
        }
      }
    }
  }

  Future<List<String>> getSchools(String uniName) async {
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
    schoolsNamesList.add('Not Selected');
    return schoolsNamesList;
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
    degreesNamesList.add('Not Selected');
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
}
