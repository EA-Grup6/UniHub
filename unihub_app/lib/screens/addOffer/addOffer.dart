import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/offer_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/screens/gmaps/gmaps.dart';

class AddOfferScreen extends StatefulWidget {
  AddOffer createState() => AddOffer();
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

class AddOffer extends State<AddOfferScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<String> coordenadas = [];

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
    "Exam",
    "Online Class",
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
            AppLocalizations.instance.text("addOffer_titleScreen"),
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
                                    child: TextFormField(
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 3),
                                          labelText: AppLocalizations.instance
                                              .text("addOffer_title"),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always),
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.instance
                                                  .text("university") +
                                              ":"),
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
                                          Text(AppLocalizations.instance
                                                  .text("college") +
                                              ":"),
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
                                          Text(AppLocalizations.instance
                                              .text("addOffer_chooseSubject")),
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
                                          Text(AppLocalizations.instance
                                              .text("search_filterType")),
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
                                                  child: Text(
                                                    AppLocalizations.instance
                                                        .text("addOffer_" +
                                                            valueItem
                                                                .toString()
                                                                .split(" ")
                                                                .join()
                                                                .toLowerCase()),
                                                  ));
                                            }).toList(),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: TextFormField(
                                      controller: _descriptionController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 3),
                                          labelText: AppLocalizations.instance
                                              .text("search_filterDescription"),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _priceController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 3),
                                          labelText: AppLocalizations.instance
                                              .text("addOffer_price"),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.greenAccent),
                                    ),
                                    child: Text(
                                      AppLocalizations.instance
                                          .text("addOffer_selectLocation"),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GMap(),
                                          )).then((result) {
                                        setState(() {
                                          coordenadas = result;
                                        });
                                      });
                                    },
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    child: Text(
                                      AppLocalizations.instance
                                          .text("addOffer_accept"),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        final int response =
                                            await OfferController().createOffer(
                                                await getUsername(),
                                                _titleController.text,
                                                valueUniversity,
                                                valueAsign,
                                                valueTipo,
                                                _descriptionController.text,
                                                _priceController.text,
                                                coordenadas[0],
                                                coordenadas[1]);
                                        if (response == 200) {
                                          createToast("Offer Created Correctly",
                                              Colors.green);
                                          Navigator.of(context).pop();
                                        } else {
                                          createToast('Error', Colors.red);
                                        }
                                      }
                                    },
                                  )
                                ]))))))));
  }
}
