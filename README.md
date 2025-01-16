# antisleep
In order for antisleep to work correctly, you need to add a few lines to the sudoers file (which will disable password prompting for these two commands) and here's how to do it:
1) Run in the terminal: sudo visudo.
2) Add the following 2 lines to the end of the file:
your_user_name ALL=(ALL) NOPASSWD: /usr/bin/pmset disablesleep 0
your_user_name ALL=(ALL) NOPASSWD: /usr/bin/pmset disablesleep 1
(change "your_user_name" to your username).
3) Save the changes (Press Esc and run :w)
4) Exit (run :x).
