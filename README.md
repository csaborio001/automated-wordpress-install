# Description
 Simple script that allows the automation of WordPress installs by just answering 3 questions.

 Generates a random user and password for the admin user.

# Usage:

    # automated-wp-install.sh                       (installs WordPress)
    # automated-wp-install.sh -plugins              (installs Wordpress + remote plugins specified)
    # automated-wp-install.sh -plugins -local       (installs Wordpress + remote plugins specified + local plugins specified)

# Version History

# Version 0.3

* The script now loads the local and remote plugins from different script files.
* Added variables for database user and database password.
* Modified Git Ignore file.
* Cleaned up ReadMe.

# Version 0.2

* Added conditionals to test against parameters for installation (thanks Pao).

# Version 0.1

* First version, basic functionality.