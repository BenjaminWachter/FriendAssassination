from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel, QVBoxLayout, QWidget, QPushButton, QMessageBox, QStackedWidget, QLineEdit, QTextEdit
import sys
from functions.player import get_players, save_players
# Import game logic functions from the new module
from functions.game_main import assign_targets
from functions.mission import generate_mission, get_missions

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Friend Assassination Game")
        self.setGeometry(100, 100, 400, 400)

        # Main container widget
        self.central_widget = QWidget(self)
        self.setCentralWidget(self.central_widget)
        # Main layout for the central widget
        self.main_layout = QVBoxLayout(self.central_widget)

        # Create QStackedWidget to manage different views
        self.stacked_widget = QStackedWidget(self)
        self.main_layout.addWidget(self.stacked_widget)

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
        self.action_widget.setLayout(self.action_layout)

        # Add action view to stacked widget
        self.stacked_widget.addWidget(self.action_widget)

        # --- Widgets for specific actions (created on demand) ---
        self.output_label = QLabel("", self)
        self.output_label.setWordWrap(True)

        self.players_editor = QTextEdit(self)
        self.save_players_button = QPushButton("Save Players", self)
        self.save_players_button.clicked.connect(self.save_edited_players)

        self.back_button = QPushButton("Back", self)
        self.back_button.clicked.connect(self.show_main_menu)

        # Initial state: Show main menu
        self.show_main_menu()

    def clear_action_layout(self):
        """Removes all widgets from the action layout."""
        while self.action_layout.count():
            child = self.action_layout.takeAt(0)
            if child.widget():
                child.widget().setParent(None)

    def show_main_menu(self):
        """Shows the main menu view."""
        self.clear_action_layout()
        self.stacked_widget.setCurrentWidget(self.menu_widget)

    def show_action_view(self):
        """Shows the action view."""
        self.stacked_widget.setCurrentWidget(self.action_widget)

    def start_game(self):
        self.clear_action_layout()
        self.show_action_view()
        current_players = get_players()
        if not current_players:
            self.output_label.setText("Error: Could not load player data.")
            self.action_layout.addWidget(self.output_label)
            self.action_layout.addWidget(self.back_button)
            return
        if len(current_players) < 2:
            self.output_label.setText("Error: Need at least 2 players to start the game.")
            self.action_layout.addWidget(self.output_label)
            self.action_layout.addWidget(self.back_button)
            return

        current_targets = assign_targets(current_players)
        output = ""
        for assassin, target in current_targets.items():
            if target:
                mission = generate_mission(target)
                output += f"{assassin}'s target: {target}\n"
                output += f"Mission for {assassin}: {mission}\n\n"
            else:
                output += f"{assassin} could not be assigned a target.\n\n"

        self.output_label.setText(output.strip())
        self.action_layout.addWidget(self.output_label)
        self.action_layout.addWidget(self.back_button)

    def edit_players(self):
        self.clear_action_layout()
        self.show_action_view()
        current_players = get_players()
        if current_players is None:
            self.output_label.setText("Error: Could not load player data.")
            self.action_layout.addWidget(self.output_label)
            self.action_layout.addWidget(self.back_button)
            return

        player_lines = []
        for name, data in current_players.items():
            friends_str = ", ".join(data.get('friends', []))
            player_lines.append(f"{name}: {friends_str}")

        self.players_editor.setPlainText("\n".join(player_lines))

        self.action_layout.addWidget(QLabel("Edit Players (Format: Name: Friend1, Friend2):"))
        self.action_layout.addWidget(self.players_editor)
        self.action_layout.addWidget(self.save_players_button)
        self.action_layout.addWidget(self.back_button)

    def save_edited_players(self):
        """Parses the text editor and saves player data."""
        text = self.players_editor.toPlainText()
        new_players_data = {}
        lines = text.split('\n')
        try:
            for line in lines:
                line = line.strip()
                if not line or ':' not in line:
                    continue

                name, friends_part = line.split(':', 1)
                name = name.strip()
                if not name:
                    continue

                friends_list = [f.strip() for f in friends_part.split(',') if f.strip()]
                new_players_data[name] = {"friends": friends_list}

            if save_players(new_players_data):
                QMessageBox.information(self, "Success", "Player data saved successfully.")
                self.show_main_menu()
            else:
                QMessageBox.warning(self, "Error", "Failed to save player data to file.")
        except Exception as e:
            QMessageBox.critical(self, "Parsing Error", f"Error parsing player data: {e}\nPlease check the format (Name: Friend1, Friend2).")

    def edit_missions(self):
        self.clear_action_layout()
        self.show_action_view()
        current_missions = get_missions()
        if not current_missions:
            self.output_label.setText("Error: Could not load mission data.")
            self.action_layout.addWidget(self.output_label)
            self.action_layout.addWidget(self.back_button)
            return

        missions_list = "\n".join([f"{method}: {desc}" for method, desc in current_missions.items()])
        self.output_label.setText(f"Current Missions:\n\n{missions_list}")
        self.action_layout.addWidget(self.output_label)
        self.action_layout.addWidget(self.back_button)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())