<?php
$folder = __DIR__ . '/kost_images';

echo "<h3>🔍 Cek Folder: kost_images</h3>";

if (!file_exists($folder)) {
    echo "❌ Folder tidak ditemukan!";
    exit;
}

if (is_writable($folder)) {
    echo "✅ Folder sudah bisa ditulis.<br>";
} else {
    echo "🔴 Folder <b>tidak bisa ditulis</b> oleh PHP (Apache).<br>";

    echo "<br><b>🛠️ Coba set permission via script PHP:</b><br>";
    $result = @chmod($folder, 0775); // or try 0777 if still fails
    clearstatcache();
    
    if ($result && is_writable($folder)) {
        echo "✅ Berhasil mengubah permission folder ke writable (0775)<br>";
    } else {
        echo "❌ Gagal mengubah permission folder secara otomatis.<br>";
        echo "🔧 Silakan beri izin secara manual:<br><pre>";
        echo "1. Klik kanan folder 'kost_images'<br>";
        echo "2. Properties > Security<br>";
        echo "3. Tambahkan 'Everyone' dengan izin: Modify + Write<br></pre>";
    }
}
?>
