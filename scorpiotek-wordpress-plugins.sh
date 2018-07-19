#!/bin/bash
# This script will install and activate the basic set of plugins for ScorpioTek websites
# You must be inside the folder where the wordpress installation will be created

# Install WP only if install switch is passed
if [ $1 == '-install' ]

then
echo -e "Name of the the database and site? "
read database_name
#echo $website_directory

# Generate a random password
RANDOM_USERNAME="$(openssl rand -base64 6)"
RANDOM_PASSWORD="$(openssl rand -base64 13)"



#Download the core
wp core download
# Create wp-config
wp config create --dbuser=root --dbpass=root --dbname="${database_name}" --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
// Directory of the project
define('APP_ROOT', dirname(__FILE__));

define('WP_HOME', 'http://localhost:8888/${database_name}/');
define('WP_SITEURL', WP_HOME);

define('WP_CONTENT_DIR', APP_ROOT . '/_content');
define('WP_CONTENT_URL', WP_HOME . '_content');
PHP

mv wp-content _content


#Install using the folder we are in as the name of the website in local host
wp core install --url=localhost:8888/"${database_name}" --title="TBD" --admin_user="${RANDOM_USERNAME}" --admin_password="${RANDOM_PASSWORD}" --admin_email=csaborio@scorpiotek.com
echo "Admin Username" "${RANDOM_USERNAME}"
echo "Admin Password" "${RANDOM_PASSWORD}"


# fi

# if [ $2 == '-plugins' ]

# then 

### --- REMOTE PLUGINS --- ###

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



### --- LOCAL PLUGINS --- ###

# Install and activate Advanced Custom Fields

wp plugin install ../_master_plugins/plugins/advanced-custom-fields-pro.zip --activate

# Install and activare Updraft Plus

wp plugin install ../_master_plugins/plugins/updraftplus.zip --activate

wp plugin install ../_master_plugins/plugins/admin-columns-pro-4-0-14.zip --activate

echo "Updating plugins..."

wp plugin update --all


fi






