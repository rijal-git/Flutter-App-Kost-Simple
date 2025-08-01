<?php
include 'koneksi.php';
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

$data = json_decode(file_get_contents("php://input"), true);
$kategori = $data['kategori'];
$isi = $data['isi'];

$stmt = $conn->prepare("UPDATE informasi_umum SET isi = ? WHERE kategori = ?");
$stmt->bind_param("ss", $isi, $kategori);
$success = $stmt->execute();

echo json_encode(['success' => $success]);
?>
