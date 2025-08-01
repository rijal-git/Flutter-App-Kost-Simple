<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
include 'koneksi.php';

$id = $_POST['id'];

if (empty($id)) {
    echo json_encode(['success' => false, 'message' => 'ID Kost tidak valid']);
    exit;
}

// Ambil nama file gambar dari database
$get = mysqli_query($conn, "SELECT gambar FROM kost WHERE id = '$id'");
$row = mysqli_fetch_assoc($get);
$gambar = $row['gambar'] ?? '';

$delete = mysqli_query($conn, "DELETE FROM kost WHERE id = '$id'");

if ($delete) {
    // Hapus file gambar jika bukan default
    if (!empty($gambar) && $gambar != 'default.jpg') {
        $filePath = __DIR__ . '/kost_images/' . $gambar;
        if (file_exists($filePath)) unlink($filePath);
    }

    echo json_encode(['success' => true, 'message' => 'Kost berhasil dihapus']);
} else {
    echo json_encode(['success' => false, 'message' => 'Gagal menghapus kost']);
}
?>
