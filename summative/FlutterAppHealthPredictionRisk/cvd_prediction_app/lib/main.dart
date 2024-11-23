import 'package:flutter/material.dart';
import 'api_service.dart'; // Import the API service

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
  final TextEditingController _generalHealthController =
      TextEditingController();
  final TextEditingController _checkupController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _bloodPressureController =
      TextEditingController();
  final TextEditingController _cholesterolController = TextEditingController();
  final TextEditingController _diabetesController = TextEditingController();
  final TextEditingController _smokingStatusController =
      TextEditingController();

  String _prediction = '';

  Future<void> _predictHealthRisk() async {
    if (_formKey.currentState!.validate()) {
      final apiService = MyApiService();

      final data = {
        'General_Health': _generalHealthController.text,
        'Checkup': _checkupController.text,
        'Age': int.tryParse(_ageController.text) ?? 0,
        'Weight': double.tryParse(_weightController.text) ?? 0.0,
        'Height': double.tryParse(_heightController.text) ?? 0.0,
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
      appBar: AppBar(title: Text('Health Risk Prediction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap the Column in SingleChildScrollView
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _generalHealthController,
                  decoration: InputDecoration(labelText: 'General Health'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your general health status';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _checkupController,
                  decoration: InputDecoration(labelText: 'Last Checkup (Date)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the date of your last checkup';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _heightController,
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bloodPressureController,
                  decoration: InputDecoration(labelText: 'Blood Pressure'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your blood pressure';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cholesterolController,
                  decoration: InputDecoration(labelText: 'Cholesterol Level'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your cholesterol level';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _diabetesController,
                  decoration:
                      InputDecoration(labelText: 'Diabetes Status (Yes/No)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your diabetes status';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _smokingStatusController,
                  decoration:
                      InputDecoration(labelText: 'Smoking Status (Yes/No)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your smoking status';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _predictHealthRisk,
                  child: Text('Predict'),
                ),
                SizedBox(height: 20),
                Text('Prediction: $_prediction',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
