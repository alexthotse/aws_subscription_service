
import 'dart:collection';
import 'dart:io';
import 'dart:convert'; //to convert json to maps and vice versa
import 'package:path_provider/path_provider.dart';
// Flutter SDK and directories
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/login_response_model.dart';

class RegisterProvider with ChangeNotifier {


  late File jsonFile;
  late Directory dir;
  String fileName = "users.json";
  bool fileExists = false;
  late Map<String, String> fileContent;

  Future<void> registerUser(String email) async {

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) () => fileContent = jsonDecode(jsonFile.readAsStringSync());
    });

    writeToFile("email", email);
    // final response = await http.post(
    //   Uri.parse("http://localhost:5050/register/"+email),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, dynamic>{
    //     // 'robot': robot,
    //     'email': email,
    //   }),
    // );
    //
    // if (response.statusCode == 201) {
    //   // If the server did return a 201 CREATED response,
    //   // then parse the JSON.
    //   notifyListeners();
    // } else {
    //   // If the server did not return a 201 CREATED response,
    //   // then throw an exception.
    //   throw Exception('Failed to create request.');
    // }

  }
  void createFile(Map<String, String> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile(String key, String value) {
    print("Writing to file!");
    Map<String, String> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, String> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    fileContent = jsonDecode(jsonFile.readAsStringSync());
    print(fileContent);
  }



}