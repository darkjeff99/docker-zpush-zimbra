#!/bin/sh +x

ZPUSH_CONFIG='/var/www/html/config.php'

#Prepare config file

if [ ! -f  "${ZPUSH_CONFIG}.bkp" ]; then
    # Backun original file
    cp $ZPUSH_CONFIG $ZPUSH_CONFIG.bkp
     cat <<- EOF >> $ZPUSH_CONFIG
     #Zimbra config
    define('MAPI_SERVER', 'file:///var/run/zarafa');
    define('ZPUSH_URL', '');
    define('ZIMBRA_URL','');
    define('ZIMBRA_USER_DIR','zimbra');
    define('ZIMBRA_SYNC_CONTACT_PICTURES', true);
    define('ZIMBRA_VIRTUAL_CONTACTS',true);
    define('ZIMBRA_VIRTUAL_APPOINTMENTS',true);
    define('ZIMBRA_VIRTUAL_NOTES',true);
    define('ZIMBRA_VIRTUAL_TASKS',true);
    define('ZIMBRA_IGNORE_EMAILED_CONTACTS',true);
    define('ZIMBRA_HTML',true);
    define('ZIMBRA_ENFORCE_VALID_EMAIL',false);
    define('ZIMBRA_SMART_FOLDERS',false);
EOF
fi

if [ -z  $ZPUSH_URL_IN_HTTP ]; then
    ZPUSH_URL_PROTO="http:\/\/"
else
     ZPUSH_URL_PROTO="https:\/\/"
fi 

if [ -z  $ZIMBRA_URL_IN_HTTP ]; then
    ZIMBRA_URL_PROTO="http:\/\/"
else
     ZIMBRA_URL_PROTO="https:\/\/"
fi 

# Config Zimbra backend
sed -i "/BACKEND_PROVIDER/s/'[^']*'/'BackendZimbra'/2" $ZPUSH_CONFIG
sed -i "/ZPUSH_URL/s/'[^']*'/'$ZPUSH_URL_PROTO$ZPUSH_URL\/Microsoft-Server-ActiveSync'/2" $ZPUSH_CONFIG
sed -i "/ZIMBRA_URL/s/'[^']*'/'$ZIMBRA_URL_PROTO$ZIMBRA_URL'/2" $ZPUSH_CONFIG

# Set timezone if exist
if  [ ! -z $TIMEZONE ]; then  
    sed -i "/TIMEZONE/s/'[^']*'/'$TIMEZONE'/2" $ZPUSH_CONFIG
fi

apache2-foreground 