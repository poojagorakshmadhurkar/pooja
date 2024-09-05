import subprocess

def run_python_script(script_path):
    """Run a Python script and check for errors."""
    result = subprocess.run(['python', script_path], capture_output=True, text=True)
    if result.returncode != 0:
        raise Exception(f"Python script failed: {result.stderr}")
    print(result.stdout)
