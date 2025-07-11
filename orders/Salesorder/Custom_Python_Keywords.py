from robot.api.deco import keyword
import pdfplumber

@keyword("Get Text From Pdf")
def get_text_from_pdf(file_path):
    """Extract text from a PDF file and return it as a string."""
    text = ""
    with pdfplumber.open(file_path) as pdf:
        for page in pdf.pages:
            content = page.extract_text()
            if content:
                text += content + "\n"
    return text.strip()
