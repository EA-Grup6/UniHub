import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/offer_controller.dart';

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

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('username');
  }

  String valueAsign;
  List listAsigns = [
    "EA",
    "MF",
    "AERO",
    "MV",
    "ITA",
    "MGTA",
    "DSA",
    "XLAM",
    "ALGEBRA",
    "AMPLI1",
    "AMPLI2",
    "PDS",
    "INFO2",
    "SX",
    "TIQ",
    "CSD"
  ];
  String valueTipo;
  List listTipo = [
    "Class",
    "Assignment",
    "Training for an exam",
  ];
  String valueUniversity;
  List listUniversity = [
    "UPC",
  ];
  String valueCollege;
  List listColleges = ['EETAC', 'EEAAB', 'ETSEIB'];

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
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Filter by university:"),
                                          DropdownButton(
                                            value: valueUniversity,
                                            onChanged: (newValue) {
                                              setState(() {
                                                valueUniversity = newValue;
                                              });
                                            },
                                            items:
                                                listUniversity.map((valueItem) {
                                              return DropdownMenuItem(
                                                value: valueItem,
                                                child: Text(valueItem),
                                              );
                                            }).toList(),
                                          ),
                                          Text("Filter by the college:"),
                                          DropdownButton(
                                            value: valueCollege,
                                            onChanged: (newValue) {
                                              setState(() {
                                                valueCollege = newValue;
                                              });
                                            },
                                            items:
                                                listColleges.map((valueItem) {
                                              return DropdownMenuItem(
                                                value: valueItem,
                                                child: Text(valueItem),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Filter by the subject:"),
                                          DropdownButton(
                                            value: valueAsign,
                                            onChanged: (newValue) {
                                              setState(() {
                                                valueAsign = newValue;
                                              });
                                            },
                                            items: listAsigns.map((valueItem) {
                                              return DropdownMenuItem(
                                                value: valueItem,
                                                child: Text(valueItem),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Filter by type:"),
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
                                      'Filter the feed',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    onPressed: () async {},
                                  )
                                ]))))))));
  }
}