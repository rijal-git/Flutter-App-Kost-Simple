<?php
include 'koneksi.php';
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

$kategori = $_GET['kategori'] ?? '';
$query = $conn->prepare("SELECT isi FROM informasi_umum WHERE kategori = ?");
$query->bind_param("s", $kategori);
$query->execute();
$result = $query->get_result();
$data = $result->fetch_assoc();

echo json_encode(['success' => true, 'isi' => $data['isi'] ?? '']);
?>
