<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
include 'koneksi.php';

$id_bayar = $_POST['id_pembayaran'] ?? '';
$aksi     = $_POST['aksi'] ?? '';   // 'terima' / 'tolak'

if (!$id_bayar || !in_array($aksi, ['terima', 'tolak'])) {
    echo json_encode(['success' => false, 'message' => 'Data tidak valid']);
    exit;
}

$status = ($aksi === 'terima') ? 'Lunas' : 'Ditolak';

$conn->begin_transaction();
try {
    // 1. update status pembayaran
    $u = $conn->prepare("UPDATE pembayaran SET status=? WHERE id=?");
    $u->bind_param('si', $status, $id_bayar);
    $u->execute();
    $u->close();

    // 2. ambil id_penghuni dari pembayaran
    $sel = $conn->prepare("SELECT id_penghuni FROM pembayaran WHERE id=?");
    $sel->bind_param('i', $id_bayar);
    $sel->execute();
    $sel->bind_result($id_penghuni);
    $sel->fetch();
    $sel->close();

    // 3. update notifikasi jadi terbaca
    $conn->query("UPDATE notifikasi SET is_read = 1 WHERE id_ref = {$id_bayar}");

    // 4. aktifkan akun jika diterima (fix bug kolom)
    if ($aksi === 'terima') {
        $act = $conn->prepare("UPDATE penghuni SET aktif = 1 WHERE id = ?");
        $act->bind_param('i', $id_penghuni);
        $act->execute();
        $act->close();
    }

    // 5. kirim notifikasi balik
    $judul = 'Konfirmasi Pembayaran';
    $pesan = ($aksi === 'terima')
        ? 'Pembayaran Anda sudah dikonfirmasi. Terima kasih.'
        : 'Pembayaran Anda ditolak. Silakan hubungi admin.';
    
    $n = $conn->prepare("INSERT INTO notifikasi(id_penghuni, judul, pesan, target) VALUES (?,?,?,'penghuni')");
    $n->bind_param('iss', $id_penghuni, $judul, $pesan);
    $n->execute();
    $n->close();

    $conn->commit();
    echo json_encode(['success' => true]);
} catch (Exception $e) {
    $conn->rollback();
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
