<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
include 'koneksi.php';

$id_penghuni = $_GET['id_penghuni'] ?? '';

$q = $conn->prepare(
    "SELECT status
       FROM pembayaran
      WHERE id_penghuni = ?
        AND status IN ('Menunggu Konfirmasi','Lunas')
   ORDER BY tanggal DESC
      LIMIT 1"
);
$q->bind_param('i', $id_penghuni);
$q->execute();
$q->bind_result($status);
$q->fetch();

echo json_encode(['status' => $status ?? 'Tidak Ada']);
?>
