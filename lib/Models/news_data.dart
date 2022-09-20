import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class NewsData with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errormessage = '';

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errormessage => _errormessage;

  Future<void> get fetchData async {
    final response = await get(
      Uri.parse('http://dl.dropbox.com/s/meadr4gzzcbbrjc/Stories.json?dl=0'),
    );

    if (response.statusCode == 200) { // That is, for when internet connection is active
      try {
        _map = jsonDecode(response.body);
        _error = false;
      }
      catch (e){
        _error = true;
        _errormessage = e.toString();
        _map = {};
      }
    } else { // If response.statuscode is not = 200
      _error = true;
      _errormessage = 'Error: It could be your internet connection';
      _map = {};
    }
    notifyListeners();
  }

  // reseting all values  back to initial values
  void initialValues() {
    _map = {};
    _error = false;
    _errormessage = '';
    notifyListeners();
  }
}
