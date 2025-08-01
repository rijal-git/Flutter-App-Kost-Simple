<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

include 'koneksi.php';

$id_penghuni = $_POST['id_penghuni'] ?? '';
$judul = $_POST['judul'] ?? '';
$pesan = $_POST['pesan'] ?? '';
$target = $_POST['target'] ?? 'penghuni';

if ($id_penghuni !== '' && $judul !== '' && $pesan !== '') {
    $stmt = $conn->prepare("INSERT INTO notifikasi_penghuni (id_penghuni, judul, pesan, target) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("isss", $id_penghuni, $judul, $pesan, $target);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Notifikasi dikirim"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Gagal mengirim notifikasi"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Data tidak lengkap"]);
}
?>
