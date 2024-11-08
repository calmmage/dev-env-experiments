# Inbox
Here I write down ideas for what I need to do

g1
- [x] Apply current nix configuration. 
- generate settings on my personal mac
    - cancelled for now
- [x] commit current state

g2 - try adding more cool settings, aliases etc..
- my Notion guide
- some random guide on the internet
- my custom aliases
    - .alias
    - .zshrc
- gpt suggestions

g3 - more hardcore tools and setups
- launchd (Launch Control)
- Local docker, mongodb etc.
- Raycast - extensions and scripts (my, custom - e.g. the nix command)

## g4 - 
.alias
.zshrc
python_startup.py

- calmlib
- frequent libs
- some tools / utils? 

## g5 - _some_ way to have the features I want
- find projects
- new project
- 

## g6 - mega-functional-requirements
- task tracking
- knowledge tracking
- code tracking / management

# Mega-projects

## complete setup script

How I want the final script to look:

1) update .nix files with local user settings (current username, hostname etc..)
2) capture initial macos settings using the mac-settings tool.py
3) install necessary intermediate things like python and stuff
4) install nix, nix-darwin and whatever else necessary (brew?)
5) apply ...
Extras
6) prompt user to set everythign up to their liking
7) capture update mac settings
8) generate updated nix files based on settings diff

## manual setup readme

d) install manually with ... App Store
- Dropover
- Flow
- Endel
e) Configure manually
- shottr
	- [ ] settings
		- [x] basic settings
		- [ ] iterate
	- [ ] license
- bartender
	- [ ] settings
		- [x] basic settings
		- [ ] iterate
	- [ ] license

# Workalong
Here I select specific things and do them

## Step 1
- [x] commit current state

## Step 2
- [x] Apply current nix configuration. 

1. Create build-nix.sh script
2. Make it executable: `chmod +x build-nix.sh`
3. Run: `./build-nix.sh`

open nix folder in terminal

## Step 3
My custom aliases

Idea: add my custom .zshrc / aliases to the nix config
Caveat:
I want them to be stored as separate files so that I could easily see what's in them and also edit them

Plan:
- download them from my repo. Put into current folder
- ask gpt how to have them as separate files

## Step 4

a) do some quick solutions right now that I need
b) plan what to add later

a)
- aliases
- zshrc

b) 
launchd -> jobs
raycast
python startup
python tools