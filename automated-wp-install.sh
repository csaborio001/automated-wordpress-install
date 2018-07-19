#!/bin/bash
# This script will install Wordpress automatically and generated a username and password for the admin.
# Additionally it allows the installation of plugins from the Wordpress repository and also the installation
# of local plugins.
# You must be inside the directory where Wordpress will be installed (which should be empty)
# You must have WP-CLI installed on your machine -> https://wp-cli.org

# Usage:

    # automated-wp-install.sh -none -none                      (installs WordPress)
    # automated-wp-install.sh -plugins              (installs Wordpress + remote plugins specified)
    # automated-wp-install.sh -plugins -local       (installs Wordpress + remote plugins specified + local plugins specified)

# Version 1.0

# Generate a random username and random password for admin
RANDOM_USERNAME="$(openssl rand -base64 6)"
RANDOM_PASSWORD="$(openssl rand -base64 13)"

echo "Admin username and password information is displayed below, make sure you write it down."
echo "Admin Username" "${RANDOM_USERNAME}"
echo "Admin Password" "${RANDOM_PASSWORD}"

echo -e "Name of the the database to be used? "
read database_name
echo -e "Name of the site to be created?"
read site_home
echo -e "Email of the admin user?"
read email_admin

#Download the core
wp core download
# Create wp-config
wp config create --dbuser=root --dbpass=root --dbname="${database_name}" --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
// Directory of the project
define('APP_ROOT', dirname(__FILE__));

define('WP_HOME', 'http://localhost:8888/${site_home}/');
define('WP_SITEURL', WP_HOME);

define('WP_CONTENT_DIR', APP_ROOT . '/_content');
define('WP_CONTENT_URL', WP_HOME . '_content');
PHP

# Rename the wp-content directory
mv wp-content _content

#Install using the folder we are in as the name of the website in local host
wp core install --url=localhost:8888/"${database_name}" --title="TBD" --admin_user="${RANDOM_USERNAME}" --admin_password="${RANDOM_PASSWORD}" --admin_email="${email_admin}"


if [ -n $1 ] # If there is something in the first parameter
then
    if [ $1 = '-plugins' ] #BUG: This always gets executed even if no parameter is passed
    then 
    ### --- REMOTE PLUGINS --- ###
    echo "Installing remote plugins..."
    # Install and Activate toolbar-publish-button, incorporate a save button in the toolbar
    wp plugin install toolbar-publish-button --activate

    # Install and Activate wps-hide-login, changes the login url for the website
    wp plugin install wps-hide-login --activate

    # Install and Activate cpt-custom-icon, contains the custom icons used for Custom Post Types
    wp plugin install cpt-custom-icon --activate

    # Install and Activate adminimize
    # wp plugin install adminimize --activate

    # Install and Activate google-analytics-for-wordpress
    wp plugin install google-analytics-for-wordpress --activate

    # Install and Activate if-menu
    wp plugin install if-menu --activate

    # Install and Activate under-construction-page
    wp plugin install under-construction-page --activate

    # Install and Activate fancy-admin-ui
    wp plugin install fancy-admin-ui --activate

    # Install and Activate wp plugin install ninja-forms
    # wp plugin install ninja-forms --activate

    # Install and Activate wp plugin install user-switching
    wp plugin install user-switching --activate

    # Install and Activate wp plugin install wp-help
    wp plugin install wp-help --activate

    # Install and Activate wp plugin advanced-cron-manager
    wp plugin install advanced-cron-manager --activate

    # Install plugin for changing avatars easily
    wp plugin install wp-user-avatar --activate 

    # Install plugin for configuring logon sreen
    wp plugin install login-customizer --activate

    fi
fi

if [ -n $2 ]
then
    if [ $2 = '-local' ]
    then
    echo "Installing local plugins..."
        # Install and activate Advanced Custom Fields
        wp plugin install ../_master_plugins/plugins/advanced-custom-fields-pro.zip --activate

        # Install and activate Updraft Plus
        wp plugin install ../_master_plugins/plugins/updraftplus.zip --activate

        # Install Admin Columns Pro (don't activate)
        wp plugin install ../_master_plugins/plugins/admin-columns-pro-4-0-14.zip 
    fi
fi

echo "Updating plugins..."

wp plugin update --all