import json
import os
import random

def load_missions(filepath="../data/missions.json"): # Path relative to mission.py
    try:
        # Path relative to this file (mission.py)
        script_dir = os.path.dirname(__file__)
        abs_file_path = os.path.join(script_dir, filepath)
        # Normalize the path to handle '../' correctly
        abs_file_path = os.path.normpath(abs_file_path)
        with open(abs_file_path, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"Error: {abs_file_path} not found.")
        return {}
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from {abs_file_path}.")
        return {}

def get_missions():
    return load_missions()

def generate_mission(target_name):
    missions_data = get_missions()
    if not missions_data:
        return "Error: Mission data could not be loaded."

    kill_methods = list(missions_data.keys())
    if not kill_methods:
        return "Error: No missions defined in the mission data."

    chosen_method = random.choice(kill_methods)
    mission_description = missions_data.get(chosen_method, "performing an unknown action.")

    mission = f"Your target is {target_name}. You must eliminate them by {mission_description}"
    return mission