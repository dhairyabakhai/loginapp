import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<dynamic> getUsername(String username, String password) async {
  var response = await http.post('http://52cc5f21.ngrok.io/auth',
  headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

  body: jsonEncode({
    "username": "$username",
    "password": "$password"
  }),
  
  );
  return response;
}