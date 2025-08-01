<?php // pindah_kamar.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); 
include 'koneksi.php';

$id     = $_POST['id_penghuni'] ?? '';
$alasan = $_POST['alasan']      ?? '';

$stmt = mysqli_prepare(
    $conn,
    "INSERT INTO permintaan_pindah (id_penghuni, alasan, status)
     VALUES (?, ?, 'Menunggu')"
);
mysqli_stmt_bind_param($stmt, 'is', $id, $alasan);

echo mysqli_stmt_execute($stmt) ? 'success' : 'error';
