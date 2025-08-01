<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

$id_penghuni = $_GET['id_penghuni'] ?? '';

if ($id_penghuni !== '') {
    $stmt = $conn->prepare("SELECT * FROM notifikasi_penghuni WHERE id_penghuni = ? OR id_penghuni = 0 ORDER BY tanggal DESC");
    $stmt->bind_param("i", $id_penghuni);
    $stmt->execute();
    $result = $stmt->get_result();
    $data = [];

    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    echo json_encode($data);
} else {
    echo json_encode([]);
}
?>
