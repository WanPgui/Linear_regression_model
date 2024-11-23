from flask import Flask, request, jsonify  # type: ignore
import pandas as pd  # type: ignore
import joblib  # type: ignore
from sklearn.preprocessing import LabelEncoder  # type: ignore

app = Flask(__name__)

# Load the trained model
model = joblib.load('model.pkl')  # Load the model

# Define the expected columns for the model
model_columns = [
    "General_Health", "Checkup", "Exercise", "Skin_Cancer", 
    "Other_Cancer", "Depression", "Diabetes", "Arthritis", 
    "Sex", "Age_Category", "Height_(cm)", "Weight_(kg)", 
    "BMI", "Smoking_History", "Alcohol_Consumption", 
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
    print("Received data:", data)  # Debugging line

    # Check if the input data is in the expected format
    if 'data' not in data or not data['data']:
        print("No data provided")  # Debugging line
        return jsonify({'error': 'No data provided'}), 400

    # Convert the input data to a DataFrame
    input_data = pd.DataFrame(data['data'])
    print("Input DataFrame shape:", input_data.shape)  # Debugging line

    # Ensure all expected columns are present
    for column in model_columns:
        if column not in input_data.columns:
            print(f'Missing column: {column}')  # Debugging line
            return jsonify({'error': f'Missing column: {column}'}), 400

    # Encode categorical variables using LabelEncoder during prediction
    categorical_columns = [
        'General_Health', 'Checkup', 'Exercise', 'Skin_Cancer', 
        'Other_Cancer', 'Depression', 'Diabetes', 'Arthritis', 
        'Sex', 'Age_Category', 'Smoking_History', 
        'Alcohol_Consumption', 'Fruit_Consumption', 
        'Green_Vegetables_Consumption', 'FriedPotato_Consumption'
    ]

    # Use a pre-fitted LabelEncoder if available
    label_encoders = {}
    for column in categorical_columns:
        if column in input_data.columns:
            le = LabelEncoder()
            input_data[column] = le.fit_transform(input_data[column])  # Fit and transform during prediction
            label_encoders[column] = le  # Store the encoder for future use if necessary

    # Reindex the DataFrame to ensure it has the correct columns
    input_data_encoded = input_data.reindex(columns=model_columns, fill_value=0)
    print("Encoded DataFrame shape:", input_data_encoded.shape)  # Debugging line

    # Make predictions
    predictions = model.predict(input_data_encoded)
    print("Predictions:", predictions)  # Debugging line
    return jsonify({'predictions': predictions.tolist()})

if __name__ == '__main__':
    app.run(debug=True)