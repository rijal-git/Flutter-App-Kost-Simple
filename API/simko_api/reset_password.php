<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

include 'koneksi.php';

$username = trim($_POST['username'] ?? '');
$new_password = trim($_POST['new_password'] ?? '');

if ($username === '' || $new_password === '') {
    echo json_encode(['success' => false, 'message' => 'Username dan password baru harus diisi']);
    exit;
}

// Hash password baru
$hashed = password_hash($new_password, PASSWORD_DEFAULT);

$stmt = $conn->prepare("UPDATE penghuni SET password = ? WHERE username = ?");
$stmt->bind_param('ss', $hashed, $username);

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => "Password untuk $username berhasil di-reset"]);
} else {
    echo json_encode(['success' => false, 'message' => 'Gagal reset password']);
}
