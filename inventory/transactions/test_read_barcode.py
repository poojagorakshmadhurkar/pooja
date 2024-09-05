from PIL import Image
import pytesseract
import sys


def ocr_from_image(image_path):
    # Specify the path to tesseract executable
    pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\tesseract.exe'

    # Open the image file
    try:
        with Image.open(image_path) as img:
            # Resize the image for better OCR results
            img = img.resize((img.width * 2, img.height * 2), Image.Resampling.LANCZOS)
            # Convert the image to grayscale to improve OCR results
            img = img.convert('L')
            # Perform OCR on the image
            text = pytesseract.image_to_string(img)
            return text
    except Exception as e:
        print(f"Error processing image: {e}")
        return None


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python test_read_barcode.py <image_path>")
        sys.exit(1)

    image_path = sys.argv[1]
    result = ocr_from_image(image_path)
    if result:
        print("OCR Results:")
        print(result)
    else:
        print("No results from OCR.")
