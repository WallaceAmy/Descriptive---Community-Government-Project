import numpy as np
import pandas as pd

# Set seed for reproducibility
np.random.seed(42)

# Define dataset sizes
num_rows = 1_000_000  # 1 million rows per table

# Generate Demographics Data
demographics = pd.DataFrame({
    "Person_ID": np.arange(1, num_rows + 1),
    "Age": np.random.randint(15, 90, num_rows),
    "Gender": np.random.choice(["Male", "Female", "Non-binary"], num_rows, p=[0.44, 0.46, 0.10]),
    "Household_Income": np.random.normal(200000, 15000, num_rows).astype(int), 
    "Employment_Status": np.random.choice(["Employed", "Unemployed", "Student", "Retired"], num_rows, p=[0.56, 0.05, 0.24, 0.15]),
    "Education_Level": np.random.choice(["High School", "Bachelor", "Master", "PhD"], num_rows, p=[0.53, 0.33, 0.09, 0.05]),
    "Ethnicity": np.random.choice(["Group A", "Group B", "Group C", "Group D"], num_rows),
    "Region": np.random.choice(["Region A", "Region B", "Region C", "Region D"], num_rows, p=[0.56, 0.05, 0.24, 0.15])
})

# Generate Infrastructure Utilization Data
infrastructure_usage = pd.DataFrame({
    "Person_ID": np.random.choice(demographics["Person_ID"], num_rows),
    "Facility_Type": np.random.choice(["Library", "Park", "Public Transport", "Community Center"], num_rows, p=[0.52, 0.30, 0.10, 0.08]),
    "Frequency_of_Use": np.random.randint(0, 30, num_rows),  # Times per month
    "Accessibility_Rating": np.random.randint(1, 6, num_rows)  # Rating 1-5
})

# Generate Community Well-being Data
wellbeing = pd.DataFrame({
    "Person_ID": np.random.choice(demographics["Person_ID"], num_rows),
    "Happiness_Score": np.random.randint(1, 11, num_rows),  # Scale 1-10
    "Mental_Health_Index": np.random.randint(0, 100, num_rows),  # Percentage
    "Civic_Engagement_Score": np.random.randint(1, 6, num_rows)  # Scale 1-5
})

# Generate Economic & Policy Data
economic_policy = pd.DataFrame({
    "Region": np.random.choice(["Region A", "Region B", "Region C", "Region D"], num_rows),
    "Government_Funding": np.random.normal(500000, 150000, num_rows).astype(int),  # Funding per region
    "Economic_Growth": np.random.uniform(0.5, 5.0, num_rows),  # Growth rate
    "Social_Benefits_Distributed": np.random.randint(1000, 50000, num_rows)
})

# Generate Geographical & Transport Data
geographical_transport = pd.DataFrame({
    "Person_ID": np.random.choice(demographics["Person_ID"], num_rows),
    "Distance_to_Nearest_Service": np.random.uniform(0.1, 50, num_rows),  # Distance in km
    "Transport_Availability": np.random.choice(["High", "Medium", "Low"], num_rows, p=[0.4, 0.4, 0.2]),
    "Land_Use_Type": np.random.choice(["Urban", "Suburban", "Rural"], num_rows, p=[0.5, 0.3, 0.2])
})

# Save datasets to CSV
demographics.to_csv("demographics2.csv", index=False)
infrastructure_usage.to_csv("infrastructure_usage2.csv", index=False)
wellbeing.to_csv("wellbeing2.csv", index=False)
economic_policy.to_csv("economic_policy2.csv", index=False)
geographical_transport.to_csv("geographical_transport2.csv", index=False)

print("Dataset generation complete. Files saved as CSV.")
