<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "sertifikasi_jmp";

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Query untuk mendapatkan semua data dari tabel `food_items`
$sql = "SELECT * FROM food_items";
$result = $conn->query($sql);

$food_items = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $food_items[] = $row;
    }
}

// Mengirimkan data dalam format JSON
echo json_encode($food_items);

// Menutup koneksi
$conn->close();
?>
