<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

// Tampilkan error untuk debugging (hilangkan di production)
ini_set('display_errors', 1);
error_reporting(E_ALL);

include 'koneksi.php';

function isValidEmail($e) {
    return filter_var($e, FILTER_VALIDATE_EMAIL);
}

function isValidPassword($p) {
    // Password minimal 8 karakter, mengandung huruf & angka
    return preg_match('/^(?=.*[A-Za-z])(?=.*\d).{8,}$/', $p);
}

// Ambil data POST dan trim spasi
$nama     = trim($_POST['nama']          ?? '');
$alamat   = trim($_POST['alamat']        ?? '');
$email    = trim($_POST['email']         ?? '');
$telepon  = trim($_POST['telepon']       ?? '');
$username = trim($_POST['username']      ?? '');
$password = trim($_POST['password']      ?? '');
$tanggal  = trim($_POST['tanggal_masuk'] ?? '');

// Validasi input wajib
if (!$nama || !$alamat || !$email || !$telepon || !$username || !$password || !$tanggal) {
    echo json_encode(['success' => false, 'message' => 'Semua field wajib diisi']);
    exit;
}

if (!isValidEmail($email)) {
    echo json_encode(['success' => false, 'message' => 'Email tidak valid']);
    exit;
}

if (!isValidPassword($password)) {
    echo json_encode(['success' => false, 'message' => 'Password harus ≥8 karakter dan mengandung huruf & angka']);
    exit;
}

// Cek username sudah ada atau belum
$cek = $conn->prepare("SELECT id FROM penghuni WHERE username = ?");

$cek->bind_param('s', $username);
$cek->execute();
$cek->store_result();

if ($cek->num_rows > 0) {
    echo json_encode(['success' => false, 'message' => 'Username sudah digunakan']);
    exit;
}

// Hash password
$hash = password_hash($password, PASSWORD_DEFAULT);

// Cek apakah kolom 'aktif' ada di tabel penghuni
$result = $conn->query("SHOW COLUMNS FROM penghuni LIKE 'aktif'");
$adaKolomAktif = $result && $result->num_rows > 0;

// Siapkan query insert sesuai ada tidaknya kolom aktif
if ($adaKolomAktif) {
    $sql = "INSERT INTO penghuni (nama, alamat, email, telepon, username, password, tanggal_masuk, aktif)
            VALUES (?, ?, ?, ?, ?, ?, ?, 0)";
} else {
    $sql = "INSERT INTO penghuni (nama, alamat, email, telepon, username, password, tanggal_masuk)
            VALUES (?, ?, ?, ?, ?, ?, ?)";
}

$ins = $conn->prepare($sql);
if (!$ins) {
    echo json_encode(['success' => false, 'message' => 'Query error: ' . $conn->error]);
    exit;
}

// Bind parameter (7 parameter, kolom aktif di-set langsung 0 di query)
$ins->bind_param('sssssss', $nama, $alamat, $email, $telepon, $username, $hash, $tanggal);

// Eksekusi dan respon
if ($ins->execute()) {
    echo json_encode([
        'success' => true,
        'message' => 'Registrasi berhasil',
        'id_penghuni' => $conn->insert_id
    ]);
} else {
    echo json_encode([
        'success' => false,
        'message' => 'Gagal menyimpan data: ' . $conn->error
    ]);
}
?>
