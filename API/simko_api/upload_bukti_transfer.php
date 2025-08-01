<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");
include 'koneksi.php';

$id = $_POST['id_pembayaran'] ?? '';
file_put_contents('debug_upload_start.txt', "id: $id\n");

if (empty($id) || !isset($_FILES['bukti_transfer'])) {
    file_put_contents('debug_upload.txt', "GAGAL: Data tidak lengkap. id: $id\n");
    echo json_encode(['success' => false, 'message' => 'Data tidak lengkap.']);
    exit;
}

$uploadDir = 'uploads/';
if (!is_dir($uploadDir)) mkdir($uploadDir);

$namaFile = uniqid() . '_' . basename($_FILES['bukti_transfer']['name']);
$targetPath = $uploadDir . $namaFile;

if (move_uploaded_file($_FILES['bukti_transfer']['tmp_name'], $targetPath)) {
    file_put_contents('debug_upload.txt', "BERHASIL UPLOAD: $targetPath\n", FILE_APPEND);

    $stmt = $conn->prepare("UPDATE pembayaran SET bukti_transfer = ? WHERE id = ?");
    $stmt->bind_param("si", $targetPath, $id);
    $success = $stmt->execute();

    if ($success) {
        file_put_contents('debug_upload.txt', "BERHASIL UPDATE: bukti_transfer = $targetPath untuk id = $id\n", FILE_APPEND);
        echo json_encode(['success' => true, 'path' => $targetPath]);
    } else {
        file_put_contents('debug_upload.txt', "GAGAL UPDATE: id = $id\n", FILE_APPEND);
        echo json_encode(['success' => false, 'message' => 'Update database gagal']);
    }
} else {
    file_put_contents('debug_upload.txt', "GAGAL MOVE FILE untuk id = $id\n", FILE_APPEND);
    echo json_encode(['success' => false, 'message' => 'Upload gagal']);
}
?>
