import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package: insertar la api de networking



import 'login.dart';

class LoggedInPage extends StatelessWidget{

  final GoogleSignInAccount user;

  const LoggedInPage({Key key, this.user}) : super(key: key);



@override
Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('Logout'),
            onPressed: () async{
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LoginScreen(),
              ));
            }, 
         ) //TextButton
        ],
      ),//AppBar
      body: Container(alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,        
        children: [
          Text('Profile',
          style: TextStyle(fontSize: 24),
          ),//Text
          SizedBox(height:32),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.photoUrl),
          ),
          SizedBox(height:8),
          Text(
            'Name: '+ user.displayName,
            style:TextStyle(color: Colors.white, fontSize: 24)
            ),
          SizedBox(height:8),
          Text(
            'Email: '+ user.email,
            style:TextStyle(color: Colors.white, fontSize: 24)
            )
      
        ],),
      ),
      );
      

          
}
