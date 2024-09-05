import os
import pdfplumber
import PyPDF2

file_path = r'C:\Users\user\Downloads\testin_2406_039.pdf'

if os.path.exists(file_path):
    print(f"The file '{file_path}' exists.")
else:
    print(f"The file '{file_path}' does not exist.")

print("Extracting text using pdfplumber:")
with pdfplumber.open(file_path) as pdf:
    for page_num, page in enumerate(pdf.pages, start=1):
        text = page.extract_text()
        print(f"Page {page_num}:")
        print(text)
        print("\n" + "-"*80 + "\n")

# Using PyPDF2
print("Extracting text using PyPDF2:")
with open(file_path, 'rb') as file:
    reader = PyPDF2.PdfReader(file)
    for page_num in range(len(reader.pages)):
        page = reader.pages[page_num]
        text = page.extract_text()
        print(f"Page {page_num + 1}:")
        print(text)
        print("\n" + "-"*80 + "\n")