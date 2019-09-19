#!/bin/bash
# This script will install Wordpress automatically and generated a username and password for the admin.
# Additionally it allows the installation of plugins from the Wordpress repository and also the installation
# of local plugins.
# You must be inside the directory where Wordpress will be installed (which should be empty)
# You must have WP-CLI installed on your machine -> https://wp-cli.org
# Version 0.4

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# Generate a random username and random password for admin
RANDOM_USERNAME="$(openssl rand -base64 6)"
RANDOM_PASSWORD="$(openssl rand -base64 13)"


echo "Admin username and password information is displayed below, make sure you write it down."
echo "Admin Username" "${RANDOM_USERNAME}"
echo "Admin Password" "${RANDOM_PASSWORD}"

echo -e "Name of the the database to be used? "
read database_name

echo -e "Database User? (default = root)"
read db_user_input
if [ -z "$db_user_input" ]
then
      DB_USER='root'
else
      DB_USER=$db_user_input
fi

echo -e "Database Password (default = root)" 
read db_pass_input
if [ -z "$db_pass_input" ]
then
      DB_PASS='root'
else
      DB_PASS=$db_pass_input
fi

echo -e "Site root? (default localhost:8888)"
read site_root_input
if [ -z "$site_root_input" ]
then
      SITE_ROOT='localhost:8888'
else
      SITE_ROOT=$site_root_input
fi

echo -e "Name of the directory of website? (default = database name)"
read site_home_input
if [ -z "$site_home_input" ]
then
      SITE_HOME=$database_name
else
      SITE_HOME=$site_home_input
fi

echo -e "Email of the admin user?"
read email_admin


#Download the core
wp core download
# Create wp-config
wp config create --dbuser=$DB_USER --dbpass=$DB_PASS --dbname="${database_name}" --force --extra-php <<PHP

define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);
define( 'SAVEQUERIES', true );

// Directory of the project
define('APP_ROOT', dirname(__FILE__));

define('WP_HOME', 'http://${SITE_ROOT}/${SITE_HOME}');
define('WP_SITEURL', WP_HOME);

define('WP_CONTENT_DIR', APP_ROOT . '/wp-content');
define('WP_CONTENT_URL', WP_HOME . '/wp-content');
PHP

# Rename the wp-content directory
# mv wp-content _content

#Install using the folder we are in as the name of the website in local host
wp core install --url="${SITE_ROOT}"/"${SITE_HOME}" --title="${SITE_HOME}" --admin_user="${RANDOM_USERNAME}" --admin_password="${RANDOM_PASSWORD}" --admin_email="${email_admin}"


if [ -n "$1" ] # If there is something in the first parameter
then
    if [ $1 = '-plugins' ] # If parameter's name is plugins
    then 
        source $DIR/remote-plugins.sh
    fi
fi

if [ -n "$2" ] # If there is something in the second parameter
then
    if [ $2 = '-local' ] # If parameter's name is local
    then
        source $DIR/local-plugins.sh
    fi
fi

echo "Updating plugins..."

wp plugin update --all

echo "All done, your site has been published at http://${SITE_ROOT}/${SITE_HOME}"