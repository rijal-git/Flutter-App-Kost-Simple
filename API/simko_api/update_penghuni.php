<?php
include 'koneksi.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

$id            = $_POST['id'] ?? '';
$nama          = $_POST['nama'] ?? '';
$alamat        = $_POST['alamat'] ?? '';
$email         = $_POST['email'] ?? '';
$telepon       = $_POST['telepon'] ?? '';
$username      = $_POST['username'] ?? '';
$tanggal_masuk = $_POST['tanggal_masuk'] ?? '';
$aktif         = $_POST['aktif'] ?? '0'; // 0 atau 1

$sql = "UPDATE penghuni SET 
          nama = ?, 
          alamat = ?, 
          email = ?, 
          telepon = ?, 
          username = ?, 
          tanggal_masuk = ?, 
          aktif = ? 
        WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sssssssi", $nama, $alamat, $email, $telepon, $username, $tanggal_masuk, $aktif, $id);
$stmt->execute();

echo json_encode(["status" => $stmt->affected_rows > 0 ? "success" : "error"]);
$conn->close();
