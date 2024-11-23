from flask import Flask, request, jsonify # type: ignore
import pandas as pd # type: ignore
import joblib # type: ignore

app = Flask(__name__)

# Load the trained model
model = joblib.load('model.pkl')

# Define the expected columns for the model
model_columns = [
    "General_Health", "Checkup", "Exercise", "Heart_Disease", 
    "Skin_Cancer", "Other_Cancer", "Depression", "Diabetes", 
    "Arthritis", "Sex", "Age_Category", "Height_(cm)", 
    "Weight_(kg)", "BMI", "Smoking_History", "Alcohol_Consumption", 
    "Fruit_Consumption", "Green_Vegetables_Consumption", 
    "FriedPotato_Consumption"
]

@app.route('/')
def home():
    return jsonify({"message": "Welcome to the Health Prediction API! Use the /predict endpoint to make predictions."})

@app.route('/predict', methods=['POST'])
def predict():
    # Get the JSON data from the request
    data = request.get_json()

    # Check if the input data is in the expected format
    if 'data' not in data or not data['data']:
        return jsonify({'error': 'No data provided'}), 400

    # Convert the input data to a DataFrame
    input_data = pd.DataFrame(data['data'])

    # Print the shape of the input data for debugging
    print("Input data shape:", input_data.shape)

    # One-hot encode categorical variables if necessary
    input_data_encoded = pd.get_dummies(input_data)

    # Reindex the DataFrame to ensure it has the correct columns
    input_data_encoded = input_data_encoded.reindex(columns=model_columns, fill_value=0)

    # Print the shape of the encoded input data for debugging
    print("Encoded input data shape:", input_data_encoded.shape)

    # Check if the input data has the correct shape
    if input_data_encoded.shape[1] != len(model_columns):
        return jsonify({'error': 'Input data has incorrect number of features'}), 400

    try:
        # Make predictions using the loaded model
        predictions = model.predict(input_data_encoded)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

    # Return the predictions as a JSON response
    return jsonify({'predictions': predictions.tolist()})

if __name__ == '__main__':
    app.run(debug=True)