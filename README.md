# antisleep
If, like me, you need to close the macbook screen so that it does not go to sleep, and at the same time you do not want to put the laptop on charge (and this is the only way to achieve this using standard settings, or I am blind and did not find it), then you can use the terminal commands are:

sudo pmset disablesleep 1 - ##Disable falling asleep
sudo pmset disablesleep 0 - ##Enable falling asleep

In order not to mess with the terminal, I wrote an App for macOS.
An important point: the app uses the same commands, but they are executed through a superuser (sudo), and in order for Antisleep to work correctly, you need to add a few lines to the sudoers file (which will disable password prompting for these two commands) and here's how to do it:

1) Run in the terminal: sudo visudo.
2) Add the following 2 lines to the end of the file:
your_user_name ALL=(ALL) NOPASSWD: /usr/bin/pmset disablesleep 0
your_user_name ALL=(ALL) NOPASSWD: /usr/bin/pmset disablesleep 1
(change "your_user_name" to your username).
3) Save the changes (Press Esc and run :w).
4) Exit (run :x).
