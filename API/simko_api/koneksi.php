<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

$host = 'localhost';
$user = 'root';
$pass = '';
$db   = 'simko_db';

$conn = mysqli_connect($host, $user, $pass, $db);

if (!$conn) {
    echo json_encode([
        'success' => false,
        'message' => 'Gagal koneksi ke database',
        'error'   => mysqli_connect_error(),
    ]);
    exit;
}
?>
