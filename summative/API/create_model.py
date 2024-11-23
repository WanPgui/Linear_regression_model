import pandas as pd # type: ignore
import numpy as np # type: ignore
import joblib # type: ignore
from sklearn.model_selection import train_test_split # type: ignore
from sklearn.linear_model import LinearRegression # type: ignore
from sklearn.preprocessing import LabelEncoder # type: ignore

# Generate a synthetic dataset
def create_synthetic_data(num_samples=1000):
    np.random.seed(42)  # For reproducibility

    # Create random data
    data = {
        'General_Health': np.random.choice(['Good', 'Fair', 'Poor'], num_samples),
        'Checkup': np.random.choice(['Yes', 'No'], num_samples),
        'Exercise': np.random.choice(['Regular', 'Occasionally', 'Never'], num_samples),
        'Heart_Disease': np.random.choice(['Yes', 'No'], num_samples),
        'Skin_Cancer': np.random.choice(['Yes', 'No'], num_samples),
        'Other_Cancer': np.random.choice(['Yes', 'No'], num_samples),
        'Depression': np.random.choice(['Yes', 'No'], num_samples),
        'Diabetes': np.random.choice(['Yes', 'No'], num_samples),
        'Arthritis': np.random.choice(['Yes', 'No'], num_samples),
        'Sex': np.random.choice(['Male', 'Female'], num_samples),
        'Age_Category': np.random.choice(['18-30', '31-45', '46-60', '60+'], num_samples),
        'Height_(cm)': np.random.randint(150, 200, num_samples),
        'Weight_(kg)': np.random.randint(50, 100, num_samples),
        'BMI': np.random.uniform(18.5, 35, num_samples),
        'Smoking_History': np.random.choice(['Non-smoker', 'Former smoker', 'Current smoker'], num_samples),
        'Alcohol_Consumption': np.random.choice(['None', 'Moderate', 'Heavy'], num_samples),
        'Fruit_Consumption': np.random.choice(['Daily', 'Occasionally', 'Never'], num_samples),
        'Green_Vegetables_Consumption': np.random.choice(['Daily', 'Occasionally', 'Never'], num_samples),
        'FriedPotato_Consumption': np.random.choice(['Daily', 'Occasionally', 'Never'], num_samples),
    }

    # Create a DataFrame
    df = pd.DataFrame(data)

    # Create a target variable (for example, predicting the likelihood of heart disease)
    df['Heart_Disease'] = np.where(df['Heart_Disease'] == 'Yes', 1, 0)  # Convert to binary

    return df

# Create a synthetic dataset
data = create_synthetic_data()

# Prepare your features and target variable
X = data.drop('Heart_Disease', axis=1)  # Features
y = data['Heart_Disease']  # Target variable

# Create label encoders for categorical features
categorical_columns = [
    'General_Health', 'Checkup', 'Exercise', 'Heart_Disease', 
    'Skin_Cancer', 'Other_Cancer', 'Depression', 'Diabetes', 
    'Arthritis', 'Sex', 'Age_Category', 'Smoking_History', 
    'Alcohol_Consumption', 'Fruit_Consumption', 
    'Green_Vegetables_Consumption', 'FriedPotato_Consumption'
]

# Initialize a LabelEncoder for each categorical column
label_encoders = {}
for column in categorical_columns:
    if column in X.columns:
        le = LabelEncoder()
        X[column] = le.fit_transform(X[column])  # Fit and transform during training
        label_encoders[column] = le  # Store the encoder for potential future use

# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train your model
model = LinearRegression()
model.fit(X_train, y_train)

# Save the trained model
joblib.dump(model, 'model.pkl')  # Save the model

# Optionally, save the label encoders for future use
# joblib.dump(label_encoders, 'label_encoders.pkl')  # Uncomment if you want to save encoders

print("Model training complete and model saved as 'model.pkl'.")