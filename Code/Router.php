<?php

namespace MVC;

class Router
{
    public array $getRoutes = [];
    public array $postRoutes = [];

    // Add a route for a GET request
    public function get($url, $fn)
    {
        $this->getRoutes[$url] = $fn;
    }

    // Add a route for a POST request
    public function post($url, $fn)
    {
        $this->postRoutes[$url] = $fn;
    }

    // Check if the current route exists
    public function checkRoutes()
    {

        // Protect routes...
        session_start();

        // Get the current URL and request method
        $currentUrl = $_SERVER['PATH_INFO'] ?? '/';
        $method = $_SERVER['REQUEST_METHOD'];

        // Get the appropriate route based on the request method
        if ($method === 'GET') {
            $fn = $this->getRoutes[$currentUrl] ?? null;
        } else {
            $fn = $this->postRoutes[$currentUrl] ?? null;
        }


        if ($fn) {
            // Call the user function when we don't know which one it will be
            call_user_func($fn, $this); // This is to pass arguments
        } else {
            echo "Page not found";
        }
    }

    // Render a view with optional data
    public function render($view, $data = [])
    {

        // Read what we pass to the view
        foreach ($data as $key => $value) {
            $$key = $value; // Double dollar sign means: variable variable, basically our variable is still the original, but when we assign it to another one it does not overwrite it, it maintains its value, so the name of the variable is dynamically assigned
        }

        ob_start(); // Memory storage for a moment...

        // Then we include the view in the layout
        include_once __DIR__ . "/views/$view.php";
        $content = ob_get_clean(); // Clear the Buffer
        include_once __DIR__ . '/views/layout.php';
    }
}
