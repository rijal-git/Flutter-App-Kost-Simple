<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$host = "localhost";
$username = "root";
$password = "";
$dbname = "simko_db";

$conn = new mysqli($host, $username, $password, $dbname);
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Koneksi database gagal']);
    exit;
}

// ✅ Tulis log semua data yang dikirim ke file log
file_put_contents('log_komplain_debug.txt', json_encode($_POST) . PHP_EOL, FILE_APPEND);

$id_penghuni = $_POST['id_penghuni'] ?? null;
$kamar       = $_POST['kamar'] ?? null;
$tentang     = $_POST['tentang'] ?? null;
$pesan       = $_POST['pesan'] ?? null;

if (!$id_penghuni || !$kamar || !$tentang || !$pesan) {
    echo json_encode(['success' => false, 'message' => 'Data tidak lengkap']);
    exit;
}

$stmt = $conn->prepare("INSERT INTO komplain (id_penghuni, kamar, tentang, pesan) VALUES (?, ?, ?, ?)");
if (!$stmt) {
    echo json_encode(['success' => false, 'message' => 'Prepare gagal: ' . $conn->error]);
    exit;
}
$stmt->bind_param("isss", $id_penghuni, $kamar, $tentang, $pesan);

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Komplain berhasil dikirim']);
} else {
    echo json_encode(['success' => false, 'message' => 'Gagal menyimpan: ' . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
