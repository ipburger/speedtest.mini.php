<?php

// Returns the size of HTTP POST
$size = 500;
$request = isset($_REQUEST)?$_REQUEST:$HTTP_POST_VARS;
foreach ($request as $key => $value) {
   $size += (strlen($key) + strlen($value) + 3);
}
echo "size={$size}";
