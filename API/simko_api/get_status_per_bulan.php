<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

$id = $_GET['id_penghuni'] ?? '';
$ym = $_GET['ym'] ?? '';

if (!$id || !$ym) {
  echo json_encode(['success' => false, 'message' => 'Invalid params']);
  exit;
}

$q = $conn->prepare("
  SELECT status FROM pembayaran
  WHERE id_penghuni = ? AND DATE_FORMAT(tanggal, '%Y-%m') = ?
  ORDER BY tanggal DESC LIMIT 1
");
$q->bind_param('is', $id, $ym);
$q->execute();
$q->bind_result($status);
$q->fetch();

echo json_encode(['status' => $status ?? 'Belum Dibayar']);
?>
