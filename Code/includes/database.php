<?php

$db = mysqli_connect('localhost', 'root', '', 'gamer_nest');


if (!$db) {
    echo "Error: Can't connect to database.";
    echo "Depuration errno: " . mysqli_connect_errno();
    echo "Depuration error: " . mysqli_connect_error();
    exit;
}
