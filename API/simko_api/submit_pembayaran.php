<?php
include 'koneksi.php'; // File koneksi ke database
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$id_penghuni = $_POST['id_penghuni'];
$metode = $_POST['metode'];
$nomor_dana = isset($_POST['nomor_dana']) ? $_POST['nomor_dana'] : null;
$nama_dana = isset($_POST['nama_dana']) ? $_POST['nama_dana'] : null;

$sql = "INSERT INTO pembayaran (id_penghuni, metode, nomor_dana, nama_dana)
        VALUES (?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("isss", $id_penghuni, $metode, $nomor_dana, $nama_dana);

$response = [];

if ($stmt->execute()) {
    $response['success'] = true;
    $response['message'] = "Pembayaran berhasil dikirim. Menunggu konfirmasi admin.";
} else {
    $response['success'] = false;
    $response['message'] = "Gagal mengirim data pembayaran: " . $stmt->error;
}

echo json_encode($response);
?>
