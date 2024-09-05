import pandas as pd
import random
from datetime import datetime

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
    'Ordered Quantity': [1000]
}

# Create DataFrame
df = pd.DataFrame(data)

# Define absolute path for the CSV file
csv_filename = r'C:\Users\user\PycharmProjects\automation\Suite\planning\Salesorder\output.csv'

# Write DataFrame to CSV
df.to_csv(csv_filename, index=False)

# Save SO number to a text file
so_number_filename = r'C:\Users\user\PycharmProjects\automation\Suite\planning\Salesorder\so_number.txt'
with open(so_number_filename, 'w') as f:
    f.write(str(so_number))

print(f"CSV file '{csv_filename}' created successfully with SO Number {so_number}.")
print(f"SO Number saved to '{so_number_filename}'.")
