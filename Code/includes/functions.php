<?php

function Debuguer($var): string
{
    echo "<pre>";
    var_dump($var);
    echo "</pre>";
    exit;
}

// sanitize and escape html
function Sanitize($html): string
{
    $result = htmlspecialchars($html);
    return $result;
}
