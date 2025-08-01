<?php
include 'koneksi.php';
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

// Parameter bulan dalam format yyyy-MM, misal "2025-08"
$bulan = $_GET['bulan'] ?? '';
if (empty($bulan)) {
    echo json_encode(['success' => false, 'message' => 'Bulan tidak valid.']);
    exit;
}

$sql = "SELECT 
    p.id AS id_pembayaran, 
    penghuni.nama AS nama, 
    IFNULL(p.nominal, 0) AS jumlah,
    p.tanggal,
    p.status,
    p.bulan,
    p.metode,
    p.bukti_transfer
FROM pembayaran AS p
JOIN penghuni ON p.id_penghuni = penghuni.id
WHERE p.bulan = ?
ORDER BY p.tanggal DESC";


$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $bulan);
$stmt->execute();
$result = $stmt->get_result();

$data = [];
while ($row = $result->fetch_assoc()) {
    $row['jumlah'] = (int) $row['jumlah'];
    $data[] = $row;
}

echo json_encode(['success' => true, 'data' => $data]);
