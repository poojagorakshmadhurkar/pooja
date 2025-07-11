import csv
import os
import random
import string
from pathlib import Path
from robot.api.deco import keyword


class CsvKeywords:

    @keyword("Read And Generate Random Data For CSV")
    def read_and_generate_random_data_for_csv(self, download_path, csv_file_name, num_rows=1):
        # Define the path to the CSV file
        csv_path = os.path.join(download_path, csv_file_name)
        generated_data = []
        fieldnames = ["Item Code", "Item Name"]

        # Check if the file exists
        file_exists = os.path.exists(csv_path)

        # Open the CSV file in 'w' mode initially to write headers
        with open(csv_path, mode='w', newline='', encoding='utf-8') as csvfile:
            writer = csv.writer(csvfile)

            # Write headers
            writer.writerow(fieldnames)  # Write headers if the file is empty

            # Generate the specified number of rows with random data
            for _ in range(num_rows):
                item_code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))
                item_name = ''.join(random.choices(string.ascii_letters, k=10))
                data = [item_code, item_name]
                generated_data.append(data)
                print(f"Generated Item Code: {item_code} | Item Name: {item_name}")

            # Write each row separately to ensure proper row handling
            for row in generated_data:
                writer.writerow(row)

        print(f"Data written to CSV file: {csv_path}")
        return generated_data

    @keyword("Get Latest Downloaded CSV File")
    def get_latest_downloaded_csv_file(self, download_path):
        # Get list of all CSV files in the folder
        csv_files = list(Path(download_path).glob("*.csv"))

        if not csv_files:
            raise ValueError(f"No CSV files found in the directory: {download_path}")

        # Sort files by modification time in descending order
        latest_file = max(csv_files, key=os.path.getmtime)

        return str(latest_file)
