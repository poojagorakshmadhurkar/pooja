import csv

def create_csv_file(file_path, data):
    with open(file_path, 'w', newline='') as csv_file:
        csv_writer = csv.writer(csv_file)
        csv_writer.writerows(data)

def edit_csv_file(file_path, row_index, column_index, new_value):
    with open(file_path, 'r') as csv_file:
        csv_reader = csv.reader(csv_file)
        data = list(csv_reader)

    # Update the specified cell
    data[row_index][column_index] = new_value

    # Save the updated data back to the CSV file
    with open(file_path, 'w', newline='') as csv_file:
        csv_writer = csv.writer(csv_file)
        csv_writer.writerows(data)

def read_csv_file(file_path):
    with open(file_path, 'r') as csv_file:
        csv_reader = csv.reader(csv_file)
        data = list(csv_reader)
    return data

# Example usage
csv_file_path = 'example.csv'
data_to_write = [
    ['Item Code','Item Name','Item Group','Quantity'],
    ['RM_001','150/0 Polyester Black','Rawmaterial1',5000],
    ['RM_002','150/0 Polyester Cora','Rawmaterial1',1000],

]

# Create and write data to CSV file
create_csv_file(csv_file_path, data_to_write)

# Edit data in CSV file
#edit_csv_file(csv_file_path, 2, 1, )

# Read data from CSV file
updated_data = read_csv_file(csv_file_path)


print("Updated CSV Data:")
for row in updated_data:
    print(row)
