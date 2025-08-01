<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); 
$host = 'localhost';
$user = 'root';
$pass = '';
$db   = 'simko_db';

$conn = mysqli_connect($host, $user, $pass, $db);
if (!$conn) {
    die("Koneksi gagal: " . mysqli_connect_error());
}
echo "Koneksi berhasil!";
?>
