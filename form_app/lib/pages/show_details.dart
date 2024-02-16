
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_app/helper/data_service.dart';

class ShowDetails extends StatefulWidget {
  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  late DataService _dataService;
  List<Map<String, String>> _users = [];

  @override
  void initState() {
    super.initState();
    _dataService = DataService();
    _loadFormData();
  }

  Future<void> _loadFormData() async {
    print('Loading form data...');
    List<Map<String, String>>? formData = await _dataService.getFormData();
    print('Decoded form data: $formData');
    if (formData != null && formData.isNotEmpty) {
      setState(() {
        _users = formData;
      });
    }
    print('Form data loaded: $_users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: _users.isEmpty
          ? Center(
        child: Text('No user details found'),
      )
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = _users[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${user['name']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text('Email: ${user['email']}'),
                  SizedBox(height: 5),
                  Text('Phone no: ${user['phone']}'),
                  SizedBox(height: 5),
                  Text('Gender: ${user['gender']}'),
                  SizedBox(height: 5),
                  Text('country: ${user['country']}'),
                  SizedBox(height: 5),
                  Text('state: ${user['state']}'),
                  SizedBox(height: 5),
                  Text('city: ${user['city']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
