import 'package:flutter/material.dart';
import 'login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'checker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'loading.dart';
import 'register.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoorStep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.white,
        primaryColor: Colors.white,
        canvasColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String username;
  String password;

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
              child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [ 
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          'Log into          your account',
                          style: 
                            TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 60.0,
                             color: Colors.white,
                            ),
                        ),
                    ),
                     Container(
                    padding: const EdgeInsets.all(40.0),
                    child:  Form(
                      autovalidate: true,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                           TextFormField(
                            decoration: InputDecoration(
                                labelText: "Enter Email", 
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.person_outline)
                                ),

                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value){
                              username = value;
                            },
                            
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                              prefixIcon: Icon(Icons.lock_outline)
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            onChanged: (value){
                              password = value;
                            },
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                          ),
                         MaterialButton(
                            height: 50.0,
                            minWidth: 150.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              
                            ),
                            color: Colors.white,
                            splashColor: Colors.black,
                            textColor: Colors.black,
                            child:  Text('Login'),
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Loading(),),);


                              var response = await getUsername(username, password);
                              //print(response.body);
                              if ( response.statusCode == 200 ) 
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Loggedin(),),);
                                //print('hi');
                              }
                              else  {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                  msg: "Invalid user, please check username and password",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  textColor: Colors.black,
                                  backgroundColor: Colors.grey,
                                  fontSize: 16.0                                
                               );
                               //print('bye');
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:80),
                            child: FlatButton(
                                child: Text(
                                'Don\'t have an account? Sign Up.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),),);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                 )
            ]
          ),
        ),
      )
    );
  }
}
