import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';

class Configuration extends StatefulWidget{
  @override 
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration>{
  String username = "";

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.username = prefs.getString('username');
    });
    return this.username;
  }
  
  @override
  void initState() {
    getUsername();
    //Aquí se llama a la API cuando cargamos esta vista
    super.initState();
  }

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back
          ),
        ),
        ),
        body: Container(
          padding: EdgeInsets.only(left:16, top:25, right:16),
          child: ListView(
            children: [
              Text("Settings", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recibir Notificaciones",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w500, 
                      color: Colors.grey[600]
                      ),
                    ),
                    Checkbox(
                        checkColor: Colors.white,
                        value: isChecked1,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        onChanged: (bool value) {
                          setState(() {
                            isChecked1 = value;
                          });
                      },
                    )
                ],
              ),
              SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Private Account",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w500, 
                      color: Colors.grey[600]
                      ),
                    ),
                    Checkbox(
                        checkColor: Colors.white,
                        value: isChecked2,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        onChanged: (bool value) {
                          setState(() {
                            isChecked2 = value;
                          });
                      },
                    )
                ],
              ),
              SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Double Security Signing in",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w500, 
                      color: Colors.grey[600]
                      ),
                    ),
                    Checkbox(
                        checkColor: Colors.white,
                        value: isChecked3,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        onChanged: (bool value) {
                          setState(() {
                            isChecked3 = value;
                          });
                      },
                    )
                ],
              ),
              TextButton(
                onPressed: () async {
                  EditProfileController().updateConf(this.username, isChecked1, isChecked2, isChecked3);
                  }, 
                child: Text("Save changes"))
            ],
          ),
        ),
    );
  }

 
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }
}