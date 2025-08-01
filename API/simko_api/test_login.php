<?php
include 'koneksi.php';
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$username = 'david';
$password = 'password_asli';

$sql = "SELECT id, password, aktif FROM penghuni WHERE username = ?";
$stmt = $conn->prepare($sql);
if (!$stmt) {
    die("Prepare failed: " . $conn->error);
}
$stmt->bind_param('s', $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 0) {
    die("Username tidak ditemukan");
}

$stmt->bind_result($id, $hashedPassword, $aktif);
$stmt->fetch();

if (!password_verify($password, $hashedPassword)) {
    die("Password salah");
}

if ($aktif != 1) {
    die("Akun belum dikonfirmasi admin");
}

echo "Login berhasil: ID = $id, aktif = $aktif";
