import numpy as np
import pandas as pd

# Set seed for reproducibility
np.random.seed(42)

# Define dataset sizes
num_rows = 50_000  # 50 thousand rows per table

# Generate Household Income with a higher frequency near the mean
income_mean = 75000  # Adjusted mean closer to center
income_std_dev = 30000  # Increased standard deviation for wider spread

# Generate a skewed normal distribution with values clustering around the mean
income_raw = np.random.normal(0, 1, num_rows)
income_transformed = income_mean + income_std_dev * income_raw * np.exp(-0.2 * income_raw**2)

# Ensure values naturally reach the desired boundaries before clipping
income_transformed = np.clip(income_transformed, 30000, 150000)

# Assign bins
income_bins = [0, 65000, 90000, 100000, np.inf]
income_labels = ['<=65K', '65K-90K', '90K-100K', '>100K']

demographics = pd.DataFrame({
    "Person_ID": np.arange(1, num_rows + 1),
    "Age": np.random.randint(15, 90, num_rows),
    "Gender": np.random.choice(["Male", "Female", "Non-binary"], num_rows, p=[0.44, 0.46, 0.10]),
    "Household_Income": np.round(income_transformed).astype(int),
    "Income_Group": pd.cut(income_transformed, bins=income_bins, labels=income_labels),
    "Employment_Status": np.random.choice(["Employed", "Unemployed", "Student", "Retired"], num_rows, p=[0.56, 0.05, 0.24, 0.15]),
    "Education_Level": np.random.choice(["High School", "Bachelor", "Master", "PhD"], num_rows, p=[0.53, 0.33, 0.09, 0.05]),
    "Ethnicity": np.random.choice(["Group A", "Group B", "Group C", "Group D"], num_rows),
    "Region": np.random.choice(["Region A", "Region B", "Region C", "Region D"], num_rows, p=[0.56, 0.05, 0.24, 0.15])
})

# Adjust Frequency of Use to follow a curved correlation with Household Income
income_bins_freq = {
    '<=65K': np.random.randint(5, 15, num_rows),  # Lower usage
    '65K-90K': np.random.randint(20, 35, num_rows),  # Peak usage
    '90K-100K': np.random.randint(15, 25, num_rows),  # Moderate usage
    '>100K': np.random.randint(5, 10, num_rows)  # Lower usage
}

demographics["Frequency_of_Use"] = demographics["Income_Group"].apply(lambda x: np.random.randint(*{
    '<=65K': (5, 15),
    '65K-90K': (20, 35),
    '90K-100K': (15, 25),
    '>100K': (5, 10)
}[x]))

# Generate Government Funding Data
region_funding = {
    "Region A": 220000,
    "Region B": 180000,
    "Region C": 90000,
    "Region D": 50000
}

economic_policy = pd.DataFrame({
    "Region": np.random.choice(["Region A", "Region B", "Region C", "Region D"], num_rows),
})
economic_policy["Government_Funding"] = economic_policy["Region"].map(region_funding) + np.random.randint(-5000, 5000, num_rows)
economic_policy["Economic_Growth"] = np.random.uniform(0.5, 5.0, num_rows)
economic_policy["Social_Benefits_Distributed"] = np.random.randint(1000, 50000, num_rows)

# Generate Distance to Nearest Service based on Government Funding
region_distance_factor = {
    "Region A": 5,
    "Region B": 15,
    "Region C": 3,
    "Region D": 20
}

demographics["Distance_to_Nearest_Service"] = demographics["Region"].map(region_distance_factor) * np.random.uniform(0.5, 1.5, num_rows)

# Generate Infrastructure Usage Data
facility_types = ["Park", "Library", "Hospital", "Shopping Center", "Sports Complex"]
infrastructure_usage = pd.DataFrame({
    "Person_ID": demographics["Person_ID"],
    "Facility_Type": np.random.choice(facility_types, num_rows),
})

# Adjust Frequency of Use based on Income Group
infrastructure_usage["Frequency_of_Use"] = infrastructure_usage["Person_ID"].apply(
    lambda pid: np.random.randint(*{
        '<=65K': (5, 15),
        '65K-90K': (20, 35),
        '90K-100K': (15, 25),
        '>100K': (5, 10)
    }[demographics.loc[demographics["Person_ID"] == pid, "Income_Group"].values[0]])
)

# Adjust Accessibility Rating based on Facility Type
facility_accessibility = {
    "Park": np.random.randint(8, 10, num_rows),  # Higher accessibility
    "Library": np.random.randint(8, 10, num_rows),  # Higher accessibility
    "Hospital": np.random.randint(5, 9, num_rows),
    "Shopping Center": np.random.randint(4, 8, num_rows),
    "Sports Complex": np.random.randint(3, 7, num_rows)
}

infrastructure_usage["Accessibility_Rating"] = infrastructure_usage["Facility_Type"].map(facility_accessibility)

# Save to Excel format
with pd.ExcelWriter("output_data.xlsx") as writer:
    demographics.to_excel(writer, sheet_name="Demographics", index=False)
    economic_policy.to_excel(writer, sheet_name="Economic Policy", index=False)
    infrastructure_usage.to_excel(writer, sheet_name="Infrastructure Usage", index=False)

print("Dataset generation complete. Files saved as Excel.")
