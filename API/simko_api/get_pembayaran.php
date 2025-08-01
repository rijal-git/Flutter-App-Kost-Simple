<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");
include 'koneksi.php';

$response = [];

if (!isset($_GET['id_penghuni'])) {
    echo json_encode([
        "status" => false,
        "message" => "Parameter id_penghuni tidak ditemukan"
    ]);
    exit;
}

$id_penghuni = $_GET['id_penghuni'];

$sql = "
SELECT 
    pembayaran.*, 
    DATE_FORMAT(pembayaran.tanggal, '%M %Y') AS bulan,
    kost.harga,
    penghuni.nama AS nama_penghuni
FROM 
    pembayaran
JOIN penghuni ON pembayaran.id_penghuni = penghuni.id_penghuni
JOIN pemesanan ON pemesanan.id_penghuni = penghuni.id_penghuni
JOIN kost ON kost.id_kost = pemesanan.id_kost
WHERE pembayaran.id_penghuni = ?
ORDER BY pembayaran.tanggal DESC
";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    echo json_encode([
        "status" => false,
        "message" => "Gagal prepare statement: " . $conn->error
    ]);
    exit;
}

$stmt->bind_param("i", $id_penghuni);
$stmt->execute();
$result = $stmt->get_result();

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode([
    "status" => true,
    "data" => $data
]);
?>
