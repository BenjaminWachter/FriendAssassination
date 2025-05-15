import unittest
import os
import sys

# Add the project root directory to the Python path
# This allows discovering modules in 'functions' and potentially other places
current_dir = os.path.dirname(os.path.abspath(__file__)) # tests directory
project_dir = os.path.dirname(current_dir) # FriendAssassination directory
sys.path.insert(0, project_dir)

if __name__ == '__main__':
    # Discover all tests in the 'tests' directory and its subdirectories
    # It looks for files matching the pattern 'test*.py' (default)
    loader = unittest.TestLoader()
    suite = loader.discover(start_dir=current_dir) # Start discovery from the 'tests' directory

    # Run the discovered tests
    runner = unittest.TextTestRunner(verbosity=2) # verbosity=2 provides more detailed output
    result = runner.run(suite)

    # Optional: Exit with a non-zero status code if tests failed
    if not result.wasSuccessful():
        sys.exit(1)