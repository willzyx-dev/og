#!/bin/bash

# Run either PHPUnit tests or PHP_CodeSniffer tests on Travis CI, depending
# on the passed in parameter.

case "$1" in
    PHP_CodeSniffer)
        cd $MODULE_DIR
        composer install
        ./vendor/bin/phpcs
        exit $?
        ;;
    *)
        ln -s $MODULE_DIR $DRUPAL_DIR/modules/og
        cd $DRUPAL_DIR
        git clone --branch 8.x-1.x https://git.drupal.org/project/composer_manager.git modules/composer_manager
        php modules/composer_manager/scripts/init.php
        composer drupal-update
        ./vendor/bin/phpunit -c ./core/phpunit.xml.dist $MODULE_DIR/tests
        exit $?
esac
