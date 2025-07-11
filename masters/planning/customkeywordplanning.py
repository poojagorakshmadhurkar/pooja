import csv
import os
import random
import string
from datetime import datetime
from faker import Faker

fake = Faker()

def generate_random_csv(file_path=None):
    # Set file path if not provided, with a timestamp to make it unique
    if not file_path:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        file_path = file_path = f"C:/Users/user/Downloads/generated_file_{timestamp}.csv"


    # Ensure the directory exists
    directory = os.path.dirname(file_path)
    if not os.path.exists(directory):
        os.makedirs(directory)

    # Define headers for CSV
    headers = ['Code', 'Name', 'Address', 'City', 'State', 'Country']

    # Generate random data
    code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))
    name = fake.name().replace(",", "")
    address = fake.address().replace("\n", " ").replace(",", "")

    # Fix city, state, and country to be within India
    indian_cities = ['Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Hyderabad', 'Kolkata', 'Pune', 'Ahmedabad', 'Jaipur', 'Lucknow']
    indian_states = ['Maharashtra', 'Delhi', 'Karnataka', 'Tamil Nadu', 'Telangana', 'West Bengal', 'Gujarat', 'Rajasthan', 'Uttar Pradesh', 'Kerala']
    indian_country = 'India'

    city = random.choice(indian_cities)
    state = random.choice(indian_states)
    country = indian_country

    # Write to CSV
    with open(file_path, 'w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(headers)
        writer.writerow([code, name, address, city, state, country])

    print(f"CSV generated at: {file_path}")
    return {'file_path': file_path, 'name': name}
