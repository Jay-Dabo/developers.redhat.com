# Used to see the demonstrator environment with data from the most recent backup of production.
#!/bin/sh
set -ex
rm -rf /drupal-workspace/drupal_$DEPLOYMENT_ID/*
if [ ! -d "/drupal-workspace/drupal_$DEPLOYMENT_ID/drupal/config/active" ]
then
    WORK_DIR="/drupal-workspace/drupal_$DEPLOYMENT_ID/work"
    mkdir -p "$WORK_DIR"
    cp "/docker-entrypoint-initdb.d/drupal-db.sql.gz" "$WORK_DIR/drupal-db.sql.gz"
    cd /var/www/drupal/web
    tar czf "$WORK_DIR/drupal-filesystem.tar.gz" config sites
    chgrp -R root "$WORK_DIR"
    chmod -R 775 "$WORK_DIR"
else
    echo "Seed of environment has already been completed"
fi