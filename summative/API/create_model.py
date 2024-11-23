import pandas as pd # type: ignore
from sklearn.linear_model import LinearRegression # type: ignore
import joblib # type: ignore

# Example data for training
data = pd.DataFrame({
    "General_Health": [1, 2, 3],  # Assuming these are numerical encodings
    "Checkup": [1, 0, 1],
    "Exercise": [1, 0, 1],
    "Heart_Disease": [0, 1, 0],
    "Skin_Cancer": [0, 0, 1],
    "Other_Cancer": [0, 1, 0],
    "Depression": [0, 0, 1],
    "Diabetes": [0, 1, 0],
    "Arthritis": [1, 0, 1],
    "Sex": [1, 0, 1],  # Male: 1, Female: 0
    "Age_Category": [1, 2, 3],  # Assuming numerical categories
    "Height_(cm)": [175, 160, 180],
    "Weight_(kg)": [70, 60, 80],
    "BMI": [22.9, 23.4, 24.7],
    "Smoking_History": [0, 1, 0],  # Non-smoker: 0, Smoker: 1
    "Alcohol_Consumption": [0, 1, 0],
    "Fruit_Consumption": [5, 2, 3],
    "Green_Vegetables_Consumption": [3, 1, 2],
    "FriedPotato_Consumption": [1, 0, 1]
})

# Target variable (example)
target = [1, 0, 1]  # Example target values

# Train the model
model = LinearRegression()
model.fit(data, target)

# Save the model
joblib.dump(model, 'model.pkl')