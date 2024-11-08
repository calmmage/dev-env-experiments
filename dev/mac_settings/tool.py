#!/usr/bin/env python3

import argparse
import json
import os
import subprocess
from pathlib import Path

src_dir = Path(__file__).parent / 'src'
def run_dump_settings(output_file):
    """Run dump_settings.py and save output to the specified file"""
    dump_script = src_dir / 'dump_settings.py'
    subprocess.run(['python3', str(dump_script), '-o', str(output_file)], check=True)

def run_diff_settings(reference_file, output_file):
    """Run diff_settings.py to compare current settings with reference"""
    diff_script = src_dir / 'diff_settings.py'
    subprocess.run(['python3', str(diff_script), '--before_file', str(reference_file), 
                   '-o', str(output_file)], check=True)

def run_clean_diff(diff_file, output_file):
    """Run clean_diff.py to clean up the diff output"""
    clean_script = src_dir / 'clean_diff.py'
    subprocess.run(['python3', str(clean_script), '--diff_file', str(diff_file),
                   '-o', str(output_file)], check=True)

def main():
    parser = argparse.ArgumentParser(description='Tool for tracking macOS settings changes')
    parser.add_argument('--keep-full-diff', action='store_true',
                      help='Keep the full diff file in addition to the cleaned version')
    args = parser.parse_args()

    script_dir = Path(__file__).parent
    output_dir = script_dir / 'output'
    output_dir.mkdir(exist_ok=True)

    reference_file = output_dir / 'reference.json'
    diff_file = output_dir / 'settings_diff.json'
    cleaned_diff_file = output_dir / 'settings_diff_cleaned.json'

    if not reference_file.exists():
        print("\nNo reference.json found. Generating initial settings snapshot...")
        run_dump_settings(reference_file)
        print(f"\nCreated reference settings file: {reference_file}")
        print("\nNow you can:")
        print("1. Set up your Mac the way you want it")
        print("2. Run this tool again to see what settings changed")
        print("3. Use the changes to update your nix configuration")
        return

    print("\nGenerating diff from reference settings...")
    run_diff_settings(reference_file, diff_file)

    print("Cleaning up the diff...")
    run_clean_diff(diff_file, cleaned_diff_file)

    # Read and display the cleaned diff
    with open(cleaned_diff_file) as f:
        cleaned_diff = json.load(f)

    if cleaned_diff:
        print("\nDetected settings changes:")
        print(json.dumps(cleaned_diff, indent=2))
    else:
        print("\nNo significant settings changes detected")

    # Clean up full diff unless --keep-full-diff was specified
    if not args.keep_full_diff and diff_file.exists():
        diff_file.unlink()
        print("\nRemoved full diff file (use --keep-full-diff to keep it)")

if __name__ == '__main__':
    main()
