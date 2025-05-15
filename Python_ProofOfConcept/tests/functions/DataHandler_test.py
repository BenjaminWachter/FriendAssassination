import unittest
import os
import json
import sys
import tempfile
import shutil

# Add the parent directory (FriendAssassination) to the Python path
# This allows importing modules from the 'functions' directory
current_dir = os.path.dirname(os.path.abspath(__file__)) # tests/functions
project_dir = os.path.dirname(os.path.dirname(current_dir)) # FriendAssassination
functions_dir = os.path.join(project_dir, 'functions') # FriendAssassination/functions
sys.path.insert(0, project_dir) # Add project root to path

# Now import the functions to be tested
from functions.DataHandler import load_data, save_data

class TestDataHandler(unittest.TestCase):

    def setUp(self):
        """Create a temporary directory and files for testing."""
        # Create a unique temporary directory for test data
        self.test_dir_root = tempfile.mkdtemp(prefix="test_datahandler_")
        # Create a 'data' subdirectory within the temp directory, mimicking the project structure
        self.test_data_dir = os.path.join(self.test_dir_root, 'data')
        os.makedirs(self.test_data_dir)

        # --- Crucial Step: Override the DataHandler's base path calculation ---
        # We need load_data and save_data to look inside our *temporary* data directory,
        # not the actual project's data directory. We achieve this by temporarily
        # modifying how DataHandler finds its 'script_dir'. We'll point it to a
        # dummy 'functions' dir inside our temp structure.

        # Create a dummy 'functions' directory inside the temp root
        self.dummy_functions_dir = os.path.join(self.test_dir_root, 'functions')
        os.makedirs(self.dummy_functions_dir)
        # Create a dummy file inside the dummy functions dir, so os.path.dirname works
        with open(os.path.join(self.dummy_functions_dir, 'DataHandler.py'), 'w') as f:
            f.write("# Dummy file for testing path resolution")

        # Store the original os.path.dirname to restore it later
        self.original_dirname = os.path.dirname

        # Monkey patch os.path.dirname: when called with the dummy DataHandler path,
        # return the path to our dummy functions directory. Otherwise, behave normally.
        dummy_handler_path = os.path.join(self.dummy_functions_dir, 'DataHandler.py')
        def mock_dirname(path):
            if os.path.abspath(path) == os.path.abspath(dummy_handler_path):
                 # Force DataHandler to think it's running from the temp functions dir
                return self.dummy_functions_dir
            return self.original_dirname(path) # Use original for other calls

        # Temporarily replace os.path.dirname with our mock version
        # NOTE: This is a common technique but can be fragile. A better approach
        # might be to refactor DataHandler to accept the base data path as an argument.
        os.path.dirname = mock_dirname

        # --- Create sample test files ---
        self.valid_endpoint = "test_valid"
        self.valid_data = {"key1": "value1", "key2": [1, 2, 3]}
        self.valid_filepath = os.path.join(self.test_data_dir, f"{self.valid_endpoint}.json")
        with open(self.valid_filepath, 'w') as f:
            json.dump(self.valid_data, f)

        self.invalid_endpoint = "test_invalid"
        self.invalid_filepath = os.path.join(self.test_data_dir, f"{self.invalid_endpoint}.json")
        with open(self.invalid_filepath, 'w') as f:
            f.write("this is not valid json")

        self.nonexistent_endpoint = "test_nonexistent"
        # No file created for this one

        self.save_endpoint = "test_save"
        self.save_filepath = os.path.join(self.test_data_dir, f"{self.save_endpoint}.json")


    def tearDown(self):
        """Remove the temporary directory and its contents."""
        # Restore the original os.path.dirname function
        os.path.dirname = self.original_dirname
        # Remove the temporary directory tree
        shutil.rmtree(self.test_dir_root)

    def test_load_data_success(self):
        """Test loading data from a valid JSON file."""
        # We pass the *endpoint name* to load_data, not the full path
        loaded_data = load_data(self.valid_endpoint)
        self.assertEqual(loaded_data, self.valid_data)

    def test_load_data_file_not_found(self):
        """Test loading data from a non-existent file."""
        # Suppress print statements during this test if desired
        # with unittest.mock.patch('builtins.print'):
        loaded_data = load_data(self.nonexistent_endpoint)
        self.assertEqual(loaded_data, {}) # Expect empty dict on failure

    def test_load_data_invalid_json(self):
        """Test loading data from an invalid JSON file."""
        # Suppress print statements during this test if desired
        # with unittest.mock.patch('builtins.print'):
        loaded_data = load_data(self.invalid_endpoint)
        self.assertEqual(loaded_data, {}) # Expect empty dict on failure

    def test_save_data_success(self):
        """Test saving data successfully."""
        data_to_save = {"a": 1, "b": "test", "c": None}
        # Pass the endpoint name and data to save_data
        save_data(self.save_endpoint, data_to_save)

        # Verify the file was created and contains the correct JSON
        self.assertTrue(os.path.exists(self.save_filepath))
        with open(self.save_filepath, 'r') as f:
            try:
                saved_data = json.load(f)
                self.assertEqual(saved_data, data_to_save)
            except json.JSONDecodeError:
                self.fail(f"Saved file {self.save_filepath} is not valid JSON.")

    # Potential future test: Test save_data failure (e.g., permissions error)
    # This is harder to simulate reliably across platforms.

if __name__ == '__main__':
    unittest.main(argv=['first-arg-is-ignored'], exit=False)