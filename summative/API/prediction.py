from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

# Load your trained model (make sure to replace 'model.pkl' with your actual model file)
model = joblib.load('model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()

    # Extract features from the request
    features = [
        data['Age'],
        data['Weight'],
        data['Height'],
        # Add other features as needed
        # For example: data['Blood_Pressure'], data['Cholesterol'], etc.
    ]

    # Convert to numpy array and reshape for the model
    features_array = np.array(features).reshape(1, -1)

    # Make prediction
    prediction = model.predict(features_array)

    # Return the prediction result
    return jsonify({'health_risk': prediction[0]})

if __name__ == '__main__':
    app.run(debug=True)