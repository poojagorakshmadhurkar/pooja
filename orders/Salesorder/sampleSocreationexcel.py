import pandas as pd
import random
from datetime import datetime
import os

# Function to generate a random SO number
def generate_random_so_number():
    return random.randint(10000, 99999)  # Random number between 10000 and 99999

# Generate random SO number
so_number = generate_random_so_number()

# Data for the CSV file
data = {
    'Customer Ref #': [12345],
    'Customer Name': ['Testcsvcustomer'],
    'So Number': [so_number],
    'So Detail': ['1234'],
    'So Start Date': [datetime(2024, 7, 23).strftime('%d-%m-%Y')],
    'So End Date': [datetime(2024, 7, 28).strftime('%d-%m-%Y')],
    'Item Code': ['222-OrangeCake'],
    'Ordered Quantity': [1000],
    'Type of Order': ['']  # Added a value so the column shows up
}

# Create DataFrame
df = pd.DataFrame(data)

# Define absolute path for the CSV file
csv_filename = r'C:\Users\user\PycharmProjects\WebAutoamtion\Suite\orders\Salesorder\output.csv'

# Check if the file exists and remove it if it does
if os.path.exists(csv_filename):
    os.remove(csv_filename)
    print(f"Existing file '{csv_filename}' removed.")
else:
    print(f"No existing file found at '{csv_filename}'.")

# Check DataFrame content before writing
print("DataFrame content:")
print(df)

# Write DataFrame to CSV, forcing column order
df.to_csv(csv_filename, index=False, columns=[
    'Customer Ref #', 'Customer Name', 'So Number', 'So Detail',
    'So Start Date', 'So End Date', 'Item Code', 'Ordered Quantity', 'Type of Order'
])

# Verify CSV creation
if os.path.exists(csv_filename):
    print(f"CSV file '{csv_filename}' created successfully.")
else:
    print(f"Failed to create CSV file at '{csv_filename}'.")

# Save SO number to a text file
so_number_filename = r'C:\Users\user\PycharmProjects\WebAutoamtion\Suite\orders\Salesorder\so_number.txt'
with open(so_number_filename, 'w') as f:
    f.write(str(so_number))

print(f"SO Number saved to '{so_number_filename}'.")

# Confirming the contents of the newly created CSV
with open(csv_filename, 'r') as f:
    print(f.read())
    print(f"File exists: {os.path.exists(csv_filename)}")

