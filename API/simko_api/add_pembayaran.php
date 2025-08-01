<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
include 'koneksi.php';
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$id_penghuni = $_POST['id_penghuni'] ?? '';
$metode      = $_POST['metode']      ?? '';
$nominal     = $_POST['nominal']     ?? '';
$catatan     = $_POST['catatan']     ?? '';
$bulan       = $_POST['bulan']       ?? '';
$status      = $_POST['status']      ?? 'Menunggu Konfirmasi';

file_put_contents('debug_post.txt', print_r($_POST, true)); 


if (empty($id_penghuni)) {
  echo json_encode(['success' => false, 'message' => 'id_penghuni kosong']);
  exit;
}
if (empty($metode)) {
  echo json_encode(['success' => false, 'message' => 'metode kosong']);
  exit;
}
if (empty($nominal)) {
  echo json_encode(['success' => false, 'message' => 'nominal kosong']);
  exit;
}
if (empty($bulan)) {
  echo json_encode(['success' => false, 'message' => 'bulan kosong']);
  exit;
}

$conn->begin_transaction();
try {
  $q = $conn->prepare("SELECT id FROM data_sewa WHERE id_penghuni = ? AND status = 'Aktif' LIMIT 1");
  $q->bind_param('i', $id_penghuni);
  $q->execute();
  $q->store_result();
  if ($q->num_rows == 0) throw new Exception('Data sewa tidak ditemukan.');
  $q->bind_result($id_sewa);
  $q->fetch();
  $q->close();

  $ins = $conn->prepare("INSERT INTO pembayaran (id_sewa, id_penghuni, bulan, metode, nominal, catatan, status)
                         VALUES (?, ?, ?, ?, ?, ?, ?)");
  $ins->bind_param('iisssss', $id_sewa, $id_penghuni, $bulan, $metode, $nominal, $catatan, $status);
  $ins->execute();
  $id_bayar = $ins->insert_id;
  $ins->close();

  $judul = 'Info';
  $pesan = "Pembayaran bulan $bulan menunggu konfirmasi.";
  $notif = $conn->prepare("INSERT INTO notifikasi (id_penghuni, id_ref, judul, pesan, target) VALUES (?, ?, ?, ?, 'admin')");
  $notif->bind_param("iiss", $id_penghuni, $id_bayar, $judul, $pesan);
  $notif->execute();
  $notif->close();

  $conn->commit();
  echo json_encode(['success' => true, 'id_pembayaran' => $id_bayar]);
} catch (Exception $e) {
  $conn->rollback();
  echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
