<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
include 'koneksi.php';
date_default_timezone_set('Asia/Jakarta');

file_put_contents('debug_get_data_sewa.txt', "\n\n--- " . date('Y-m-d H:i:s') . " ---\n", FILE_APPEND);

$id = $_GET['id_penghuni'] ?? '';
if (!$id) {
    echo '[]';
    exit;
}

$stmt = mysqli_prepare($conn,
  "SELECT ds.*, k.kamar, k.ukuran, k.fasilitas, k.harga, k.gambar
   FROM data_sewa ds 
   JOIN kost k ON k.id = ds.id_kost
   WHERE ds.id_penghuni=? AND ds.status='Aktif' LIMIT 1");

mysqli_stmt_bind_param($stmt, 'i', $id);
mysqli_stmt_execute($stmt);
$res = mysqli_stmt_get_result($stmt);

$data = [];
$baseURL = 'http://192.168.182.125/simko_api/kost_images/';

while ($row = mysqli_fetch_assoc($res)) {
    file_put_contents('debug_get_data_sewa.txt', print_r($row, true), FILE_APPEND);
    $row['gambar'] = $baseURL . $row['gambar'];
    $data[] = $row;
}

echo json_encode($data);