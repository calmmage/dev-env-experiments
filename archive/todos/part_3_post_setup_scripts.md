Idea:

1) Right now I am settings and installing everything manually.
For example, installing nix, then creating nix files with scripts etc.

2) After I set everything up here,
I will create a bunch of nix files to save to github
And I won't need to edit them manually anymore

3) So, I want to create a script that I will be able to run later on a new mac
To install everything automatically based just on this repo.

So there will be three separate realities:

Reality 1:
Full journey that I'm doing currently 
Includes manual steps and set-ups
As well as scripts and commands I generate along the way

Reality 2:
The scripted part of reality 1. 



Reality 3:
The new script that I will be able to run like this:
- git clone this repo
- cd into the repo
- ./dev/scripts/setup.sh

-> installs nix, uses existing nix files, applies to system
