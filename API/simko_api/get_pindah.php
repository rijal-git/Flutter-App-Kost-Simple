<?php // get_pindah.php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
include 'koneksi.php';

$res = mysqli_query($conn,
  "SELECT * FROM permintaan_pindah WHERE status='Menunggu'");
echo json_encode(mysqli_fetch_all($res, MYSQLI_ASSOC));
?>