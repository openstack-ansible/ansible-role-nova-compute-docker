#!/bin/sh
/usr/bin/glance-manage db_sync
/usr/bin/mysql -h {{ glance_mysql_host }} -P {{ glance_mysql_port }} \
    -u glance --password="{{ glance_mysql_glance_password }}" glance <<EOF
ALTER TABLE glance.migrate_version CONVERT TO CHARACTER SET 'utf8' 
EOF
/usr/bin/glance-manage db_sync
/usr/bin/mysql -h {{ glance_mysql_host }} -P {{ glance_mysql_port }} \
    -u glance --password="{{ glance_mysql_glance_password }}" glance <<EOF
SET foreign_key_checks = 0;
ALTER TABLE glance.image_locations CONVERT TO CHARACTER SET 'utf8';
ALTER TABLE glance.image_members CONVERT TO CHARACTER SET 'utf8';
ALTER TABLE glance.image_properties CONVERT TO CHARACTER SET 'utf8';
ALTER TABLE glance.image_tags CONVERT TO CHARACTER SET 'utf8';
ALTER TABLE glance.images CONVERT TO CHARACTER SET 'utf8';
ALTER TABLE glance.migrate_version CONVERT TO CHARACTER SET 'utf8';
SET foreign_key_checks = 1
EOF
