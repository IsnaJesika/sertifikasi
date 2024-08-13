<?php
header('Content-Type: application/json'); // Mengatur header untuk mengirimkan data dalam format JSON

include '../connection.php';
  // Menghubungkan ke database menggunakan file koneksi yang terpisah

$sql = "SELECT * FROM transactions";  // Query untuk mengambil semua data dari tabel transactions
$result = $connect->query($sql);  // Menjalankan query

$transactions = [];  // Inisialisasi array untuk menyimpan hasil query
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {  // Looping untuk setiap baris hasil query
        $transactions[] = $row;  // Menambahkan setiap baris ke array transactions
    }
}
if ($result === false) {
    echo json_encode(['success' => false, 'error' => $connect->error]);
    exit;
}
echo json_encode($transactions);  // Mengubah array transactions menjadi format JSON dan mengirimkannya

$connect->close();  // Menutup koneksi database
?>
