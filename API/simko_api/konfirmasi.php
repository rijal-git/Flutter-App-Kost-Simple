<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
include 'koneksi.php';

// Debugging (hapus atau komen jika tidak dibutuhkan)
// echo json_encode($_POST); exit;

$tipe = $_POST['tipe'] ?? '';
$idPermintaan = $_POST['id'] ?? '';
$idPenghuni = $_POST['id_penghuni'] ?? '';

// Validasi parameter
if (!$tipe || !$idPermintaan || !$idPenghuni) {
    echo json_encode(['status' => 'error', 'msg' => 'Parameter kurang lengkap']);
    exit;
}

// Tentukan nama tabel berdasarkan tipe permintaan
$table = '';
$statusAktif = 1; // default aktif

if ($tipe === 'pindah') {
    $table = 'permintaan_pindah';
    $statusAktif = 1; // tetap aktif
} elseif ($tipe === 'berhenti') {
    $table = 'permintaan_berhenti';
    $statusAktif = 0; // nonaktifkan akun
} else {
    echo json_encode(['status' => 'error', 'msg' => 'Tipe tidak dikenali']);
    exit;
}

// Mulai transaksi
mysqli_begin_transaction($conn);

try {
    // Update status permintaan
    $stmt1 = mysqli_prepare($conn, "UPDATE $table SET status = 'Dikonfirmasi' WHERE id = ?");
    mysqli_stmt_bind_param($stmt1, 'i', $idPermintaan);
    mysqli_stmt_execute($stmt1);
    if (mysqli_stmt_affected_rows($stmt1) === 0) {
        throw new Exception("Gagal update status permintaan (ID tidak ditemukan)");
    }

    // Update status aktif penghuni sesuai tipe permintaan
    $stmt2 = mysqli_prepare($conn, "UPDATE penghuni SET aktif = ? WHERE id = ?");
    mysqli_stmt_bind_param($stmt2, 'ii', $statusAktif, $idPenghuni);
    mysqli_stmt_execute($stmt2);
    if (mysqli_stmt_affected_rows($stmt2) === 0) {
        throw new Exception("Gagal update status penghuni (ID tidak ditemukan)");
    }

    // Jika berhasil semua
    mysqli_commit($conn);
    echo json_encode(['status' => 'success']);
} catch (Exception $e) {
    mysqli_rollback($conn);
    echo json_encode(['status' => 'error', 'msg' => $e->getMessage()]);
}
?>
