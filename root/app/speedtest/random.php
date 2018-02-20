<?php
// Inspired by https://github.com/adolfintel/speedtest/blob/master/garbage.php

//Variables
$jpgsize=$_GET["jpgsize"];
if(!empty($jpgsize)) $BYTES_TO_SEND = 1.9 * pow((int) $jpgsize, 2); // equation derived from looking at the average sizes of images provided by speedtest.net

if (!isset($FILENAME)) $FILENAME = "random{$jpgsize}x{$jpgsize}.jpg";
if (!isset($CHUNK_SIZE)) $CHUNK_SIZE = 1024 * 1024; // in bytes = 1MB
if (!isset($BYTES_TO_SEND)) $BYTES_TO_SEND = 100 * 1024 * 1024; // in bytes = 100MB
$CHUNK_SIZE = $CHUNK_SIZE < $BYTES_TO_SEND ? $CHUNK_SIZE : $BYTES_TO_SEND;

// Disable Compression
@ini_set('zlib.output_compression', 'Off');
@ini_set('output_buffering', 'Off');
@ini_set('output_handler', '');

// Headers
header('HTTP/1.1 200 OK');

// Download follows...
header('Content-Description: File Transfer');
header('Content-Type: image/jpg');
header("Content-Disposition: attachment; filename={$FILENAME}");
header('Content-Transfer-Encoding: binary');

// Never cache me
header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
header('Cache-Control: post-check=0, pre-check=0', false);
header('Pragma: no-cache');

// Generate data
$chunk=openssl_random_pseudo_bytes($CHUNK_SIZE);

// Deliver chunks of data until total bytes are sent
$chunks_to_send = ceil($BYTES_TO_SEND/$CHUNK_SIZE);

for($i=0; $i<$chunks_to_send; $i++) {
    echo $chunk;
    flush();
}
