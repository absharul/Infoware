import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataService {

  Future<void> saveFormData(List<Map<String, String>> formData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String formDataJson = jsonEncode(formData);
    await prefs.setString('formData', formDataJson);
  }

  Future<List<Map<String, String>>?> getFormData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? formDataJson = prefs.getString('formData');
    if (formDataJson != null && formDataJson.isNotEmpty) {
      final List<dynamic> decodedData = jsonDecode(formDataJson);
      final List<Map<String, String>> formDataList = decodedData.map((dynamic item) {
        if (item is Map<String, String>) {
          return item;
        } else if (item is Map<String, dynamic>) {
          // Convert the dynamic map to a map with String values
          return item.map((key, value) => MapEntry(key, value.toString()));
        } else {
          // Handle other cases here if needed
          return <String, String>{};
        }
      }).toList();
      return formDataList;
    }
    return null;
  }




}
