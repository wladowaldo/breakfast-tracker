Breakfast Tracker
=================
# What
Keeps track of who bought breakfast and when they did it. 

# Prerequisites
Docker.

# How
* Run `gui.sh` and access the GUI on port 8022. 
* The person at the top of the list is the one whose turn it is to buy breakfast next. 
* When she/he has successfully done her/his duty, select the person in the dropdown list and press the "Breakfast is served!" button to record the occasion.
* Persons can be removed and added from the list via the GUI.

# Misc
* Very non-production-ready - uses the Vite and the Flask dev servers.
* The database is hand-editable (it's in `work/`).

