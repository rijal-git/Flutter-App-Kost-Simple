<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');

include 'koneksi.php';

file_put_contents('debug_edit_kost.txt', "START EDIT\n", FILE_APPEND);

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Hanya menerima metode POST']);
    exit;
}

$id        = $_POST['id']        ?? '';
$kamar     = $_POST['kamar']     ?? '';
$ukuran    = $_POST['ukuran']    ?? '';
$fasilitas = $_POST['fasilitas'] ?? '';
$harga     = $_POST['harga']     ?? '';
$status    = $_POST['status']    ?? 'Kosong';

file_put_contents('debug_edit_kost.txt', print_r($_POST, true), FILE_APPEND);

if (!$id || !$kamar || !$ukuran || !$fasilitas || !$harga) {
    echo json_encode(['success' => false, 'message' => 'Semua field wajib diisi']);
    exit;
}

// Ambil gambar lama
$gambar = 'default.jpg';
$get = mysqli_query($conn, "SELECT gambar FROM kost WHERE id = '$id'");
if ($row = mysqli_fetch_assoc($get)) {
    $gambar = $row['gambar'];
}

// Upload gambar baru (jika ada)
if (isset($_FILES['gambar']) && $_FILES['gambar']['error'] === UPLOAD_ERR_OK) {
    $uploadDir = __DIR__ . '/kost_images/';
    if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);

    $fileTmpPath = $_FILES['gambar']['tmp_name'];
    $fileName = basename($_FILES['gambar']['name']);
    $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));

    if (!in_array($fileExtension, ['jpg', 'jpeg', 'png', 'gif'])) {
        echo json_encode(['success' => false, 'message' => 'Ekstensi file tidak valid']);
        exit;
    }

    $newFileName = uniqid('kost_', true) . '.' . $fileExtension;
    $destPath = $uploadDir . $newFileName;

    if (move_uploaded_file($fileTmpPath, $destPath)) {
        // Hapus lama
        if (!empty($gambar) && $gambar !== 'default.jpg' && file_exists(__DIR__ . '/kost_images/' . $gambar)) {
            unlink(__DIR__ . '/kost_images/' . $gambar);
        }
        $gambar = $newFileName;
        file_put_contents('debug_edit_kost.txt', "Gambar baru: $gambar\n", FILE_APPEND);
    } else {
        echo json_encode(['success' => false, 'message' => 'Gagal upload gambar baru']);
        exit;
    }
}

$stmt = $conn->prepare("UPDATE kost SET kamar=?, ukuran=?, fasilitas=?, harga=?, status=?, gambar=? WHERE id=?");
$stmt->bind_param('sssissi', $kamar, $ukuran, $fasilitas, $harga, $status, $gambar, $id);

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Kost berhasil diperbarui']);
} else {
    echo json_encode(['success' => false, 'message' => 'Gagal memperbarui kost']);
}
?>
