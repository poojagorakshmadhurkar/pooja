import csv


def create_csv_and_get_content(filename, rows, columns):
    with open(filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(columns)  # Write the column headers

        for row in rows:
            writer.writerow(row)

    # Read the CSV content from the file and return it as a string
    with open(filename, 'r') as csvfile:
        csv_content = csvfile.read()

    return csv_content


# Example usage
def create_csv_item():
    rows = [
        ['Capcitor', 'electronics', 'Blue', 12, 'Small', 'SMF'],
        ['Resistor', 'electronics', 'Green', 32, 'Small', 'SMF'],
        ['Diode', 'electronics', 'Red', 32, 'Small', 'SMF'],
    ]
    columns = ['Label', 'Description', 'Colour', 'Density', 'Viscosity', 'Factory Unit']

    filename = 'data.csv'
    csv_content = create_csv_and_get_content(filename, rows, columns)
    return csv_content