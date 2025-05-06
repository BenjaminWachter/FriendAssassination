import json
import os

# Function to load player data from JSON
def load_players(filepath="../data/users.json"): # Adjusted path
    """Loads player data from a JSON file."""
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
    
def save_players(players, filepath="../data/users.json"): # Adjusted path
    """Saves player data to a JSON file."""
    try:
        # Ensure the path is correct relative to this file's location
        script_dir = os.path.dirname(__file__)  # <-- absolute dir the script is in (functions)
        abs_file_path = os.path.join(script_dir, filepath)
        # Normalize the path to handle '../' correctly
        abs_file_path = os.path.normpath(abs_file_path)
        with open(abs_file_path, 'w') as f:
            json.dump(players, f, indent=4)
    except Exception as e:
        print(f"Error saving players: {e}") # Use absolute path in error

def get_players():
    """Returns the loaded player data."""
    return load_players()

def edit_player(player_name, new_data):
    """Edits a player's data."""
    players = load_players()
    if player_name in players:
        players[player_name].update(new_data)
        save_players(players)
        return True
    return False