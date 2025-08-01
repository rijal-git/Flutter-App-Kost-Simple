<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
include 'koneksi.php'; // koneksi ke MySQL

$id = $_GET['id'] ?? '';

$sql = "SELECT id, nama, alamat, email, telepon, username, tanggal_masuk, aktif
        FROM penghuni
        WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $id);
$stmt->execute();

$result = $stmt->get_result();
$data = $result->fetch_assoc();

echo json_encode($data ?: []);
$conn->close();
