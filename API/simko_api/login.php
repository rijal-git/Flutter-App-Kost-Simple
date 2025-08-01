<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

include 'koneksi.php';

$username = trim($_POST['username'] ?? '');
$password = trim($_POST['password'] ?? '');

// Debug log untuk cek data masuk
error_log("USERNAME: [$username]");
error_log("PASSWORD RAW LENGTH: " . strlen($password));

if ($username === 'admin' && $password === 'admin123') {
    echo json_encode(['success' => true, 'role' => 'admin']);
    exit;
}

$sql = "SELECT id, password, aktif FROM penghuni WHERE username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param('s', $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 0) {
    echo json_encode(['success' => false, 'message' => 'Username tidak ditemukan']);
    exit;
}

$stmt->bind_result($id, $hashedPassword, $aktif);
$stmt->fetch();
error_log("CEK USERNAME: [$username]");
error_log("CEK PASSWORD: [$password]");
error_log("CEK AKTIF DARI DB: [$aktif]");

// Tambahkan log cek password
error_log("Password DB hash: [$hashedPassword]");
error_log("Password input plain: [$password]");
if (password_verify($password, $hashedPassword)) {
    error_log("Password verified!");
} else {
    error_log("Password verification failed!");
    echo json_encode(['success' => false, 'message' => 'Password salah']);
    exit;
}

if ($aktif != 1) {
    echo json_encode(['success' => false, 'message' => 'Akun belum dikonfirmasi admin']);
    exit;
}

echo json_encode(['success' => true, 'role' => 'penghuni', 'id_penghuni' => $id]);
