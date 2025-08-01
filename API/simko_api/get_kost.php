<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: *");

include 'koneksi.php';

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$baseURL = 'http://192.168.182.125/simko_api/kost_images/'; // ganti sesuai server/ngrok kamu

try {
    $res = mysqli_query($conn, "SELECT * FROM kost");
    $rows = [];
    while ($r = mysqli_fetch_assoc($res)) {
        // Buat URL gambar
        $r['gambar'] = $baseURL . $r['gambar'];
        $rows[] = $r;
    }
    echo json_encode($rows);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?>
