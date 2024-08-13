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

// Mengambil ID dari parameter query string
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Menggunakan prepared statement untuk mencegah SQL Injection
$stmt = $conn->prepare("SELECT * FROM food_items WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode($row);
} else {
    echo json_encode([]);
}

// Menutup statement dan koneksi
$stmt->close();
$conn->close();
?>
