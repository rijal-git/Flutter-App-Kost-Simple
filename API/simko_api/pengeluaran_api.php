<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
include 'koneksi.php';
$conn = new mysqli("localhost", "root", "", "simko_db");

$input = json_decode(file_get_contents("php://input"), true);
$action = $input['action'] ?? '';
$response = ['success' => false];

if ($action === 'get') {
    $bulan = $conn->real_escape_string($input['bulan']);
    $result = $conn->query("SELECT * FROM pengeluaran WHERE bulan = '$bulan' ORDER BY id_pengeluaran DESC");
    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    $response = ['success' => true, 'data' => $data];
}
elseif ($action === 'add') {
    $stmt = $conn->prepare("INSERT INTO pengeluaran (bulan, keterangan, jumlah) VALUES (?, ?, ?)");
    $stmt->bind_param("ssi", $input['bulan'], $input['keterangan'], $input['jumlah']);
    $response['success'] = $stmt->execute();
}
elseif ($action === 'edit') {
    $stmt = $conn->prepare("UPDATE pengeluaran SET bulan=?, keterangan=?, jumlah=? WHERE id_pengeluaran=?");
    $stmt->bind_param("ssii", $input['bulan'], $input['keterangan'], $input['jumlah'], $input['id_pengeluaran']);
    $response['success'] = $stmt->execute();
}
elseif ($action === 'delete') {
    $stmt = $conn->prepare("DELETE FROM pengeluaran WHERE id_pengeluaran=?");
    $stmt->bind_param("i", $input['id_pengeluaran']);
    $response['success'] = $stmt->execute();
}

echo json_encode($response);
