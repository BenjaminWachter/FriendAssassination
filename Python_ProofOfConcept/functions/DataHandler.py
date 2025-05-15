import json
import os

def load_data(endpoint):
    filepath = "../data/"+endpoint+".json"  # Adjusted path
    try:
        # Ensure the path is correct relative to this file's location
        script_dir = os.path.dirname(__file__)  # <-- absolute dir the script is in (functions)
        abs_file_path = os.path.join(script_dir, filepath)
        # Normalize the path to handle '../' correctly
        abs_file_path = os.path.normpath(abs_file_path)
        with open(abs_file_path, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"Error: {abs_file_path} not found.") # Use absolute path in error
        return {}
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from {abs_file_path}.") # Use absolute path in error
        return {}
    
def save_data(endpoint, data):
    filepath = "../data/"+endpoint+".json"  # Adjusted path
    try:
        # Ensure the path is correct relative to this file's location
        script_dir = os.path.dirname(__file__)  # <-- absolute dir the script is in (functions)
        abs_file_path = os.path.join(script_dir, filepath)
        # Normalize the path to handle '../' correctly
        abs_file_path = os.path.normpath(abs_file_path)
        with open(abs_file_path, 'w') as f:
            json.dump(data, f, indent=4)
    except Exception as e:
        print(f"Error saving data: {e}") # Use absolute path in error