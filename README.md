# CVD Prediction Model

## API Endpoint
- **URL**: [https://e325-34-67-145-129.ngrok-free.app/predict](https://e325-34-67-145-129.ngrok-free.app/predict)

## How to Run the Mobile App
1. Clone the repository.
2. Navigate to the `FlutterApp/cvd_prediction_app` directory.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to start the app.

## Video Demo
- [YouTube Video Demo](https://youtu.be/gSmdsRUJAcU) 


# Health Risk Prediction Flutter App

## Overview

This Flutter application allows users to input their health information and receive a prediction regarding their health risks. The app communicates with a backend API to perform the prediction based on the provided data.

## Features

- User-friendly interface for entering health information.
- Validation of input fields to ensure data integrity.
- API integration for health risk prediction.
- Display of prediction results or error messages.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Project Structure](#project-structure)
3. [API Integration](#api-integration)
4. [Postman API Documentation](#postman-api-documentation)
5. [Run the App](#run-the-app)
6. [Contributing](#contributing)
7. [License](#license)

## Getting Started

### Prerequisites

- Flutter SDK
- Dart
- An IDE (e.g., Visual Studio Code, Android Studio)
- A backend API for health risk prediction

### Installation

1. Clone the repository:

   ```bash
   git clone CVD_PREDICTION_APP #CardioVascular Prediction App(Heart Risk Prediction App)
   cd cvd_prediction_app


   Project Structure
/cvd_prediction_app
│
├── lib/
│   ├── api_service.dart        # API service for making requests
│   └── main.dart               # Main application file
│
├── pubspec.yaml                # Flutter dependencies
└── README.md                   # Project documentation

API Integration
The app communicates with a backend API for health risk prediction. The API endpoint is defined in the api_service.dart file.

API Endpoint
URL: https://e325-34-67-145-129.ngrok-free.app/predict
Method: POST
Content-Type: application/json
Request Body
The request body should be in the following JSON format:
{
  "General_Health": "Good",
  "Checkup": "Yes",
  "Age": 30,
  "Weight": 70.5,
  "Height": 1.75,
  "Blood_Pressure": "120/80",
  "Cholesterol": "Normal",
  "Diabetes": "No",
  "Smoking_Status": "No"
}

Response
The API will return a JSON response containing the predicted health risk:

{
  "health_risk": "Low"
}


Postman API Documentation
You can use Postman to test the API endpoints. Follow these steps to set up Postman:

Open Postman and create a new request.
Set the request type to POST.
Enter the API URL: https://e325-34-67-145-129.ngrok-free.app/predict.
In the Headers tab, add Content-Type with the value application/json.
In the Body tab, select raw and enter the JSON data as shown above.
Click Send to make the request.
Example Postman Collection
You can import the following JSON into Postman to quickly set up the request:

{
  "info": {
    "_postman_id": "your-postman-id",
    "name": "Health Risk Prediction API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Predict Health Risk",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "Content-Type",
            "value": "application/json"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\"General_Health\":\"Good\",\"Checkup\":\"Yes\",\"Age\":30,\"Weight\":70.5,\"Height\":1.75,\"Blood_Pressure\":\"120/80\",\"Cholesterol\":\"Normal\",\"Diabetes\":\"No\",\"Smoking_Status\":\"No\"}"
        },
        "url": {
          "raw": "https://your-public-api-url/predict",
          "protocol": "https",
          "host": ["your-public-api-url"],
          "path": ["predict"]
        }
      },
      "response": []
    }
  ]
}



Run the App
Ensure you have a working Flutter environment.

Replace the placeholder URL in api_service.dart with your actual API endpoint.

Run the app using the command:

flutter run


## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please fork the repository and submit a pull request. You can also open an issue to discuss any ideas or problems you encounter.

### Steps to Contribute

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature/my-feature



   Make your changes and commit them:
git commit -m "Add some feature"

Push to the branch:

git push origin feature/my-feature


Open a pull request.


License
This project is licensed under the MIT License - see the LICENSE file for details.

Acknowledgements
Flutter - The framework used for building the app.
Postman - For testing API endpoints.
Any other libraries or tools that were used in the development of this project.
Contact
For any questions or feedback, feel free to reach out:

Your Name: p.wangui@alustudent.com
GitHub: WanPgui
Thank you for checking out this project!

