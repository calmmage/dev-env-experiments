from datetime import datetime
from pathlib import Path

# noinspection PyUnresolvedReferences
import pytest

from dev_env import CalmmageDevEnv
from dev_env.core.presets import latest_preset


def test_setup_root_dir(tmp_path):
    """
    Test that the create_root method correctly creates the root directory and its subdirectories.
    """
    # Create CalmmageEnv class object at the temp path
    dev_env = CalmmageDevEnv(tmp_path, setup=False)

    # Run the create_root method
    dev_env._setup_root_dir()

    # Validate the created folders

    expected_folders = latest_preset.dirs  # replace with the actual folder
    # names
    for folder in expected_folders:
        assert (tmp_path / folder).exists(), f"{folder} was not created"


# If you want to use pytest clea
if __name__ == "__main__":
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
    tmp_path = Path(f"./tmp/root_dir_{timestamp}").absolute()
    print(tmp_path)
    test_setup_root_dir(tmp_path)
