<?php
include 'koneksi.php';
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$id = $_GET['id'] ?? 0;

$query = "SELECT id, status, tanggal FROM pembayaran WHERE id = $id";
$result = mysqli_query($koneksi, $query);
$row = mysqli_fetch_assoc($result);

echo json_encode([
  'success' => true,
  'data' => $row
]);
