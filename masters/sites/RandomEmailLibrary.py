import random
import string


def generate_random_email(length=8, domain='example.com'):
    """
    Generates a random email address with a specified length for the username part.
    The first letter of the username part is capitalized and the rest are lowercase.

    Args:
        length (int): The length of the random string for the username part of the email.
        domain (str): The domain part of the email address.

    Returns:
        str: A randomly generated email address.
    """
    if length <= 0:
        raise ValueError("Length must be a positive integer")

    characters = string.ascii_letters + string.digits  # Letters and numbers
    username = ''.join(random.choices(characters, k=length)).lower()
    username = username.capitalize()  # Capitalize the first letter
    email = f"{username}@{domain}"
    return email
