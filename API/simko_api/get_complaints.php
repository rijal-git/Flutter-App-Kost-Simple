<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$host = "localhost";
$username = "root";
$password = "";
$dbname = "simko_db";

$conn = new mysqli($host, $username, $password, $dbname);
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Koneksi gagal']);
    exit;
}

$sql = "SELECT 
            k.id, 
            k.kamar, 
            k.tentang, 
            k.pesan, 
            k.created_at, 
            IFNULL(p.nama, '-') AS nama
        FROM komplain k
        LEFT JOIN penghuni p ON k.id_penghuni = p.id
        ORDER BY k.created_at DESC";

$result = $conn->query($sql);
if (!$result) {
    echo json_encode(['success' => false, 'message' => 'Query error: ' . $conn->error]);
    exit;
}

$komplain = [];
while ($row = $result->fetch_assoc()) {
    $komplain[] = [
        'nama' => $row['nama'],
        'tanggal' => $row['created_at'],
        'tentang' => $row['tentang'],
        'pesan' => $row['pesan'],
        'kamar' => $row['kamar'],
    ];
}

echo json_encode($komplain);
$conn->close();
?>
