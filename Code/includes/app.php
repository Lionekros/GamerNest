<?php

require 'functions.php';
require 'database.php';
require __DIR__ . '/../vendor/autoload.php';

// connect to db
use Model\ActiveRecord;

ActiveRecord::setDB($db);
