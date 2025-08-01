<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');

include 'koneksi.php';
date_default_timezone_set('Asia/Jakarta');

// Log semua POST dan FILES
file_put_contents('debug_add_kost.txt', "--- " . date('Y-m-d H:i:s') . " ---\n", FILE_APPEND);
file_put_contents('debug_add_kost.txt', "POST:\n" . print_r($_POST, true), FILE_APPEND);
file_put_contents('debug_add_kost.txt', "FILES:\n" . print_r($_FILES, true), FILE_APPEND);

// Validasi method
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Hanya menerima metode POST']);
    exit;
}

// Ambil data
$kamar     = $_POST['kamar']     ?? '';
$ukuran    = $_POST['ukuran']    ?? '';
$fasilitas = $_POST['fasilitas'] ?? '';
$harga     = $_POST['harga']     ?? '';
$status    = $_POST['status']    ?? 'Kosong';

if (!$kamar || !$ukuran || !$fasilitas || !$harga) {
    echo json_encode(['success' => false, 'message' => 'Semua field wajib diisi']);
    exit;
}

// --- Proses Upload Gambar ---
$gambar = 'default.jpg';

if (isset($_FILES['gambar'])) {
    $uploadError = $_FILES['gambar']['error'];
    if ($uploadError === UPLOAD_ERR_OK) {
        $uploadDir = 'kost_images/';
        if (!file_exists($uploadDir)) mkdir($uploadDir, 0775, true);

        $fileTmpPath = $_FILES['gambar']['tmp_name'];
        $fileName = basename($_FILES['gambar']['name']);

        // Deteksi dan validasi ekstensi
        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
        file_put_contents('debug_add_kost.txt', "Nama file: $fileName\n", FILE_APPEND);
        file_put_contents('debug_add_kost.txt', "Ekstensi: $fileExtension\n", FILE_APPEND);

        if (empty($fileExtension)) {
            echo json_encode(['success' => false, 'message' => 'Ekstensi file tidak terdeteksi', 'name' => $fileName]);
            exit;
        }

        $allowedExt = ['jpg', 'jpeg', 'jpe', 'png', 'gif'];
        if (!in_array($fileExtension, $allowedExt)) {
            echo json_encode(['success' => false, 'message' => 'Ekstensi file tidak valid', 'ext' => $fileExtension]);
            exit;
        }

        // Proses simpan
        $newFileName = uniqid('kost_', true) . '.' . $fileExtension;
        $destPath = $uploadDir . $newFileName;

        if (move_uploaded_file($fileTmpPath, $destPath)) {
            file_put_contents('debug_add_kost.txt', "GAMBAR BERHASIL DIPINDAH: $destPath\n", FILE_APPEND);
            $gambar = $newFileName;
        } else {
            file_put_contents('debug_add_kost.txt', "GAGAL MOVE FILE: $fileTmpPath ke $destPath\n", FILE_APPEND);
            echo json_encode(['success' => false, 'message' => 'Gagal memindahkan file gambar']);
            exit;
        }
    } else {
        file_put_contents('debug_add_kost.txt', "UPLOAD ERROR KODE: $uploadError\n", FILE_APPEND);
        echo json_encode(['success' => false, 'message' => 'Upload error: ' . $uploadError]);
        exit;
    }
}

// Simpan ke database
$stmt = mysqli_prepare($conn,
    "INSERT INTO kost (kamar, ukuran, fasilitas, harga, status, gambar)
     VALUES (?, ?, ?, ?, ?, ?)"
);

mysqli_stmt_bind_param($stmt, 'sssiss',
    $kamar, $ukuran, $fasilitas, $harga, $status, $gambar
);

if (mysqli_stmt_execute($stmt)) {
    file_put_contents('debug_add_kost.txt', "✅ DATA KOST BERHASIL DITAMBAHKAN\n\n", FILE_APPEND);
    echo json_encode(['success' => true, 'message' => 'Kost berhasil ditambahkan']);
} else {
    file_put_contents('debug_add_kost.txt', "❌ GAGAL INSERT DB: " . mysqli_error($conn) . "\n", FILE_APPEND);
    echo json_encode(['success' => false, 'message' => 'Gagal menambah kost']);
}
?>
