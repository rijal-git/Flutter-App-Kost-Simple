<?php
// File: get_notif_pembayaran.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
include 'koneksi.php';

$sql = "
SELECT n.id AS id_notif,
       n.id_ref AS id_pembayaran,
       p.id_penghuni,
       p.nominal,
       p.metode,
       p.tanggal,
       p.status
  FROM notifikasi n
  JOIN pembayaran p ON p.id = n.id_ref
 WHERE n.target = 'admin'
   AND n.id_ref IS NOT NULL
ORDER BY n.id DESC
";
$res = $conn->query($sql);
$data = [];
while ($row = $res->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode($data);