<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$host = "localhost";
$user = "root";
$pass = "";
$db   = "simko_db";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

header('Content-Type: application/json');

// ✅ Tambahkan kolom 'aktif' ke query
$sql = "SELECT id, nama, email, aktif FROM penghuni";
$result = $conn->query($sql);

$penghuni = [];
while ($row = $result->fetch_assoc()) {
    $penghuni[] = $row;
}

echo json_encode($penghuni);
$conn->close();
?>
