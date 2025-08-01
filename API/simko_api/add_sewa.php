<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
include 'koneksi.php';

$idPenghuni = $_POST['id_penghuni'] ?? '';
$idKost     = $_POST['id_kost']     ?? '';

if (!$idPenghuni || !$idKost) {
    echo json_encode(['success'=>false,'msg'=>'param kosong']); exit;
}

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

try {
    // insert ke data_sewa
    $stmt = mysqli_prepare($conn,
        "INSERT INTO data_sewa(id_penghuni,id_kost,tanggal_mulai,status) 
         VALUES (?,?,NOW(),'Aktif')");
    mysqli_stmt_bind_param($stmt,'ii',$idPenghuni,$idKost);
    mysqli_stmt_execute($stmt);

    // ubah status kamar → Terisi
    $u = mysqli_prepare($conn,"UPDATE kost SET status='Terisi' WHERE id=?");
    mysqli_stmt_bind_param($u,'i',$idKost);
    mysqli_stmt_execute($u);

    echo json_encode(['success'=>true]);
} catch (Exception $e) {
    echo json_encode(['success'=>false,'msg'=>$e->getMessage()]);
}
