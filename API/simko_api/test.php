<?php
header('Content-Type: text/plain');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo "Gunakan POST method\n";
  exit;
}

if (empty($_FILES)) {
  echo "🛑 Tidak ada file yang diterima (upload gagal)\n";
  print_r($_FILES);
  exit;
}

if (!isset($_FILES['gambar'])) {
  echo "🛑 Key 'gambar' tidak ditemukan di \$_FILES\n";
  print_r($_FILES);
  exit;
}

$success = move_uploaded_file($_FILES['gambar']['tmp_name'], 'kost_images/test.jpg');
echo $success ? "✅ BERHASIL simpan\n" : "❌ GAGAL simpan\n";

echo "\n--- FILE INFO ---\n";
print_r($_FILES['gambar']);
