<?php

require_once __DIR__ . '/../includes/app.php';

use MVC\Router;

$router = new Router();




// Checks and validates the routes, ensuring that they exist and assigns the functions of the Controller to them.
$router->checkRoutes();
