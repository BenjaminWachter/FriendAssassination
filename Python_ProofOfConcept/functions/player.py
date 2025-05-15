import json
import os
from functions.DataHandler import load_data, save_data

    
def save_players(players, filepath="../data/users.json"): # Adjusted path
    save_data("players", players)

def get_players():
    return load_data("players")

def edit_player(player_name, new_data):
    players = get_players()
    if player_name in players:
        players[player_name].update(new_data)
        save_players(players)
        return True
    return False