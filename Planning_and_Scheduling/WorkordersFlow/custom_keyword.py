import os
import glob
import csv


def get_latest_csv_file(directory):
    pattern = os.path.join(directory, '*.csv')
    files = glob.glob(pattern)

    if not files:
        raise ValueError("No CSV files found in the directory.")

    latest_file = max(files, key=os.path.getmtime)
    return latest_file


def read_workorder_column_from_csv(directory):
    latest_file = get_latest_csv_file(directory)

    workorder_data = []

    with open(latest_file, mode='r', newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)

        # Check for the 'Work Order' column
        if 'Work Order' not in reader.fieldnames:
            raise ValueError(
                f"The 'Work Order' column is not found in the CSV file. Available columns: {reader.fieldnames}")

        for row in reader:
            workorder_data.append(row['Work Order'])  # Updated to use 'Work Order'

    return workorder_data
