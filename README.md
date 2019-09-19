# Description

This script will install WordPress in no time by quickly asking you a few questions.

# Instructions

1. Create the database where you will install WordPress, remember its name.
2. Create a directory in your **sites** folder where you will install WordPress.
3. Place the **automated-wordpress-install** folder next to the directory you defined in (2)
4. CD into your site directory (defined in 2)
5. Type the following command:

`../automated-wordpress-install/automated-wp-install.sh`

6. Answer the questions, pay attention to the username/password generated for your as output of the script:`

![AdminPass](https://lh4.googleusercontent.com/e1IfZFX-jMVPwGfK1TfqzOF5UoU7UjuTz2-GmU4EROM1AVvKJsHJKFQwuGI)

7. WordPress will install and update any plugins. 

## Other options

If you would like to install additional plugins, you can define these two files:

* remote-plugins.sh
* local-plugins.sh

Inside each file you can define plugins you would like to install by writing the corresponding WP-CLI argument.

Then you can invoice them as such:

`automated-wp-install.sh -plugins              (installs Wordpress + remote plugins specified)`
`automated-wp-install.sh -plugins -local       (installs Wordpress + remote plugins specified + local plugins specified)`
`

## Version History

### Version 0.4

* Made the script more interactive by asking DB credentials, home directory, and site root.
* Rewrote ReadMe with correct instructions. 

### Version 0.3

* The script now loads the local and remote plugins from different script files.
* Added variables for database user and database password.
* Modified Git Ignore file.
* Cleaned up ReadMe.

### Version 0.2

* Added conditionals to test against parameters for installation (thanks Pao).

### Version 0.1 

* First version, basic functionality.