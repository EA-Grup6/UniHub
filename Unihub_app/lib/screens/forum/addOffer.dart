import 'package:flutter/material.dart';

class AddOfferScreen extends StatefulWidget {
  AddOffer createState() => AddOffer();
}

class AddOffer extends State<AddOfferScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
    "UPC, EETAC",
    "UPC, ETSEIB",
    "UPC, EEAAB",
    "UPC, ETSETB",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Offer",
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
                                          labelText: "Title of the offer",
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
                                          Text("Choose the university:"),
                                          DropdownButton(
                                            value: valueUniversity,
                                            onChanged: (newValue) {
                                              setState(() {
                                                valueAsign = newValue;
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
                                        ],
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Choose the subject:"),
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
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: TextFormField(
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 3),
                                          labelText: "Description",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 3),
                                          labelText: "Price (€/h)",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    child: Text(
                                      'Add Offer to the feed',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ]))))))));
  }
}
