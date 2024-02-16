import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_app/helper/data_service.dart';
import 'package:form_app/pages/Successful.dart';
import 'package:form_app/pages/show_details.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Form App"),
        actions: [
         Padding(padding: EdgeInsets.all(10.0),
         child:  ElevatedButton.icon(
           onPressed: (){
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => ShowDetails()
               )
             );
           },
           icon: Icon(Icons.history),
           label: Text('Saved Data'),
           style: ButtonStyle(
             fixedSize: MaterialStateProperty.all<Size>(
               Size(150, 20), // Adjust the height and width as needed
             ),
           ),
         ),)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text("Personal Details",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600
                ),),
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone',border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0,),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(labelText: 'Gender',border: OutlineInputBorder(),),
                items: <String>['Male', 'Female', 'Other']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country',border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State',border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City',border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 300,
                child:  ElevatedButton(
                  // Inside MyHomePage Widget
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, String> result = {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                          'gender': _gender ?? '',
                          'country': _countryController.text,
                          'state': _stateController.text,
                          'city': _cityController.text,
                        };

                        print('Form Data to be saved: $result');

                        String formDataJson = jsonEncode(result);
                        print('Encoded Form Data: $formDataJson');

                        await DataService().saveFormData([result]);

                        print('Form Data Saved Successfully');

                        _formKey.currentState!.reset();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SuccessfulPage()),
                        );
                      }
                    },
                    style: ButtonStyle(

                  ),
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}