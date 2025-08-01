<?php
include 'koneksi.php';
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

// Ambil parameter dari URL
$id_penghuni = $_GET['id_penghuni'] ?? '';

// Validasi parameter
if (!$id_penghuni || !is_numeric($id_penghuni)) {
    echo json_encode(['success' => false, 'isi' => 'ID tidak valid']);
    exit;
}

// Gunakan kolom `id` (bukan `id_penghuni`) dan `telepon` (bukan `no_hp`)
$query = $conn->prepare("SELECT nama, email, telepon FROM penghuni WHERE id = ?");
$query->bind_param("i", $id_penghuni);
$query->execute();

$result = $query->get_result();
$data = $result->fetch_assoc();

if ($data) {
    echo json_encode([
        'success' => true,
        'isi' => "Nama: {$data['nama']}\nEmail: {$data['email']}\nNo. HP: {$data['telepon']}"
    ]);
} else {
    echo json_encode(['success' => false, 'isi' => 'Data tidak ditemukan']);
}
?>
