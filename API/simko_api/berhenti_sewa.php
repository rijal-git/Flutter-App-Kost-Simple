<?php
include 'koneksi.php';

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

// Ambil data dari POST
$id_penghuni = $_POST['id_penghuni'] ?? '';
$alasan = $_POST['alasan'] ?? '';

// Validasi sederhana
if (empty($id_penghuni) || empty($alasan)) {
    echo json_encode([
        'success' => false,
        'message' => 'ID penghuni dan alasan wajib diisi'
    ]);
    exit;
}

// Gunakan prepared statement untuk keamanan
$stmt = $conn->prepare("INSERT INTO permintaan_berhenti (id_penghuni, alasan) VALUES (?, ?)");
$stmt->bind_param("is", $id_penghuni, $alasan);

if ($stmt->execute()) {
    echo json_encode([
        'success' => true,
        'message' => 'Permintaan berhenti berhasil dikirim'
    ]);
} else {
    echo json_encode([
        'success' => false,
        'message' => 'Gagal menyimpan ke database'
    ]);
}
?>
