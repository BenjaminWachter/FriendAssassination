from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel, QVBoxLayout, QWidget, QPushButton, QMessageBox, QStackedWidget
import sys
from functions.player import get_players  # Import the loaded players data
# Import game logic functions from the new module
from functions.game_main import assign_targets # Only import assign_targets
from functions.mission import generate_mission, get_missions # Import generate_mission from mission.py

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Friend Assassination Game")
        self.setGeometry(100, 100, 400, 300)

        # Main container widget
        self.central_widget = QWidget(self)
        self.setCentralWidget(self.central_widget)
        # Main layout for the central widget
        self.main_layout = QVBoxLayout(self.central_widget)

        # Create QStackedWidget to manage different views
        self.stacked_widget = QStackedWidget(self)
        self.main_layout.addWidget(self.stacked_widget) # Add stack to main layout

        # --- Create Main Menu View ---
        self.menu_widget = QWidget()
        self.menu_layout = QVBoxLayout(self.menu_widget)

        self.start_button = QPushButton("Start Game", self)
        self.start_button.clicked.connect(self.start_game)
        self.menu_layout.addWidget(self.start_button)

        self.edit_players_button = QPushButton("Edit Players", self)
        self.edit_players_button.clicked.connect(self.edit_players)
        self.menu_layout.addWidget(self.edit_players_button)

        self.edit_missions_button = QPushButton("Edit Missions", self)
        self.edit_missions_button.clicked.connect(self.edit_missions)
        self.menu_layout.addWidget(self.edit_missions_button)

        # Add menu view to stacked widget
        self.stacked_widget.addWidget(self.menu_widget)

        # --- Create Action View ---
        self.action_widget = QWidget()
        self.action_layout = QVBoxLayout(self.action_widget)

        self.output_label = QLabel("", self)
        self.output_label.setWordWrap(True) # Allow text wrapping
        self.action_layout.addWidget(self.output_label)

        self.back_button = QPushButton("Back", self)
        self.back_button.clicked.connect(self.show_main_menu) # Connect to show main menu
        self.action_layout.addWidget(self.back_button)

        # Add action view to stacked widget
        self.stacked_widget.addWidget(self.action_widget)

        # Initial state: Show main menu
        self.show_main_menu()

    def show_main_menu(self):
        """Shows the main menu view."""
        self.stacked_widget.setCurrentWidget(self.menu_widget)
        self.output_label.clear() # Clear previous output when returning to menu

    def show_action_view(self):
        """Shows the action view."""
        self.stacked_widget.setCurrentWidget(self.action_widget)

    def start_game(self):
        self.show_action_view() # Switch to action view
        current_players = get_players()
        if not current_players:
            self.output_label.setText("Error: Could not load player data.")
            return
        # Check if there are enough players to start the game
        if len(current_players) < 2:
             self.output_label.setText("Error: Need at least 2 players to start the game.")
             return
        current_targets = assign_targets(current_players)
        output = ""
        for assassin, target in current_targets.items():
            if target:
                mission = generate_mission(target) # Assuming generate_mission doesn't need missions_data passed
                output += f"{assassin}'s target: {target}\n"
                output += f"Mission for {assassin}: {mission}\n\n"
            else:
                # This case might happen if assignment fails for some reason (e.g., only one player)
                output += f"{assassin} could not be assigned a target.\n\n"
        self.output_label.setText(output.strip())


    def edit_players(self):
        self.show_action_view() 
        current_players = get_players()
        if not current_players:
            self.output_label.setText("Error: Could not load player data.")
            return

        players_list = "\n".join([f"{name}: Friends - {', '.join(data.get('friends', []))}" for name, data in current_players.items()])
        self.output_label.setText(f"Current Players:\n\n{players_list}" if players_list else "No players found.")


    def edit_missions(self):
        self.show_action_view()
        current_missions = get_missions()
        if not current_missions:
            self.output_label.setText("Error: Could not load mission data.")
            return
        
        missions_list = "\n".join([f"{method}: {desc}" for method, desc in current_missions.items()])
        self.output_label.setText(f"Current Missions:\n\n{missions_list}")

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())