import random
import json
import os

def assign_targets(players_data, current_round_targets=None):
    """Assigns targets to players based on friend lists and constraints."""
    # Make a copy to avoid modifying the original dictionary directly if needed elsewhere
    current_players_state = players_data.copy()
    available_targets = {player: list(data["friends"]) for player, data in current_players_state.items()}
    new_targets = {}

    player_names = list(current_players_state.keys()) # Get list of players

    # Shuffle players to randomize assignment order, helps prevent predictable patterns
    random.shuffle(player_names)

    # Keep track of who has been assigned as a target
    assigned_targets = set()

    for assassin in player_names:
        data = current_players_state[assassin]
        potential_targets = list(data["friends"])

        # Remove self from potential targets
        if assassin in potential_targets:
            potential_targets.remove(assassin)

        # Remove already assigned targets from potential list
        potential_targets = [t for t in potential_targets if t not in assigned_targets]

        # Remove previous target if applicable
        if current_round_targets and assassin in current_round_targets:
            previous_target = current_round_targets.get(assassin)
            if previous_target in potential_targets:
                potential_targets.remove(previous_target)

        # Optional: Prevent assigning the person targeting the assassin (requires 'targeted_by' to be up-to-date)
        # targeters = data.get("targeted_by", [])
        # potential_targets = [t for t in potential_targets if t not in targeters]


        if potential_targets:
            target = random.choice(potential_targets)
            new_targets[assassin] = target
            current_players_state[assassin]["target"] = target
            assigned_targets.add(target) # Mark this target as assigned

            # Update target's 'targeted_by' list
            if "targeted_by" not in current_players_state[target]:
                current_players_state[target]["targeted_by"] = []
            # Avoid adding duplicates if re-running assignment logic
            if assassin not in current_players_state[target]["targeted_by"]:
                 current_players_state[target]["targeted_by"].append(assassin)
        else:
            # Handle case where no valid target is left for the assassin
            # This might indicate an issue with the friend graph or assignment logic
            print(f"Warning: No valid target could be assigned for {assassin}.")
            new_targets[assassin] = None # Assign None or handle as error
            # Need to decide if this assassin should still be assignable as a target

    # Optional: Check if everyone got a target, handle imbalances if necessary
    if len(new_targets) != len(players_data):
        print("Warning: Not all players were assigned a target.")

    # Note: This function modifies the 'current_players_state' dictionary (a copy of the input)
    # but only returns the 'new_targets'. If state changes need to persist,
    # the modified state should also be returned or handled differently.
    return new_targets