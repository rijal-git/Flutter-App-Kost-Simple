<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");
include 'koneksi.php';

$id_penghuni = $_GET['id_penghuni'] ?? '';
if (!$id_penghuni) {
    echo json_encode(['success' => false, 'message' => 'ID penghuni tidak boleh kosong.']);
    exit;
}

// Ambil tanggal masuk & harga
$cek = $conn->prepare("
  SELECT p.tanggal_masuk, k.harga
  FROM penghuni p
  JOIN data_sewa s ON s.id_penghuni = p.id
  JOIN kost k ON k.id = s.id_kost
  WHERE p.id = ? AND s.status = 'Aktif'
  LIMIT 1
");
$cek->bind_param('i', $id_penghuni);
$cek->execute();
$cek->bind_result($tanggal_masuk, $harga);
$cek->fetch();
$cek->close();

if (!$tanggal_masuk) {
    echo json_encode(['success' => false, 'message' => 'Data penghuni tidak ditemukan.']);
    exit;
}

// Ambil pembayaran berdasarkan id_penghuni
$bayar = [];
$ambil = $conn->prepare("
    SELECT bulan, status
    FROM pembayaran
    WHERE id_penghuni = ?
");
$ambil->bind_param('i', $id_penghuni);
$ambil->execute();
$hasil = $ambil->get_result();

while ($row = $hasil->fetch_assoc()) {
    $bulanStr = $row['bulan']; // contoh: '2025-08'
    $bulanTime = strtotime($bulanStr . "-01"); // ✅ FIX: gunakan format yang valid
    $ymKey = date('Y-m', $bulanTime);          // hasil: '2025-08'
    $bayar[$ymKey] = $row['status'];           // mapping status per bulan
}
$ambil->close();

// Susun respons 12 bulan ke depan
$response = [];
$dt = new DateTime();
for ($i = 0; $i < 12; $i++) {
    $ym = $dt->format('Y-m'); // '2025-07', dst
    $bulanIndo = strftime('%B %Y', $dt->getTimestamp());
    $status = $bayar[$ym] ?? 'Belum Dibayar';

    $response[] = [
        'bulan' => $bulanIndo,
        'ym' => $ym,
        'status' => $status,
        'nominal' => $harga,
    ];
    $dt->modify('+1 month');
}

echo json_encode($response);
