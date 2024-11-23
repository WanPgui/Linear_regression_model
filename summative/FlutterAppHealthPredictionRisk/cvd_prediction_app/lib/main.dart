// lib/main.dart

import 'package:flutter/material.dart';
import 'api_service.dart'; // Import the API service
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Risk Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _generalHealthController = TextEditingController();
  final TextEditingController _checkupController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _cholesterolController = TextEditingController();
  final TextEditingController _diabetesController = TextEditingController();
  final TextEditingController _smokingStatusController = TextEditingController();

  String _prediction = '';

  Future<void> _predictHealthRisk() async {
    if (_formKey.currentState!.validate()) {
      final apiService = MyApiService(); // Create an instance of MyApiService

      final data = {
        'General_Health': _generalHealthController.text,
        'Checkup': _checkupController.text,
        'Age': int.tryParse(_ageController.text),
        'Weight': double.tryParse(_weightController.text),
        'Height': double.tryParse(_heightController.text),
        'Blood_Pressure': _bloodPressureController.text,
        'Cholesterol': _cholesterolController.text,
        'Diabetes': _diabetesController.text,
        'Smoking_Status': _smokingStatusController.text,
      };

      try {
        final prediction = await apiService.predictHealthRisk(data);
        setState(() {
          _prediction = prediction;
        });
      } catch (e) {
        setState(() {
          _prediction = 'Error: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Risk Prediction'),
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Enter Your Health Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(_generalHealthController, 'General Health'),
                  _buildTextField(_checkupController, 'Checkup (Yes/No)'),
                  _buildTextField(_ageController, 'Age', isNumber: true),
                  _buildTextField(_weightController, 'Weight (kg)', isNumber: true),
                  _buildTextField(_heightController, 'Height (m)', isNumber: true),
                  _buildTextField(_bloodPressureController, 'Blood Pressure'),
                  _buildTextField(_cholesterolController, 'Cholesterol'),
                  _buildTextField(_diabetesController, 'Diabetes (Yes/No)'),
                  _buildTextField(_smokingStatusController, 'Smoking Status (Yes/No)'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _predictHealthRisk,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                                        child: Text('Predict', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _prediction.isEmpty 
                      ? 'Prediction will appear here' 
                      : 'Predicted Health Risk: $_prediction',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.blueAccent
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          if (isNumber && double.tryParse(value) == null) {
            return 'Please enter a valid number for $label';
          }
          return null;
        },
      ),
    );
  }
}