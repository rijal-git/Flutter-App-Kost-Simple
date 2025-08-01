<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
include 'koneksi.php';

try {
    $res = mysqli_query($conn, "
        SELECT id_kost, COUNT(*) as jumlah_terisi
        FROM data_sewa
        WHERE status = 'Aktif'
        GROUP BY id_kost
    ");

    $result = [];
    while ($row = mysqli_fetch_assoc($res)) {
        $result[$row['id_kost']] = (int)$row['jumlah_terisi'];
    }

    echo json_encode($result);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?>
