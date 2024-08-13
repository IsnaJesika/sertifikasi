<?php
header('Content-Type: application/json');

include '../connection.php';
 // Pastikan path ke connect.php benar

// Mengambil data dari body request
$data = json_decode(file_get_contents('php://input'), true);

// Mendapatkan nilai dari data yang dikirim
$food_id = $data['food_id'];
$quantity = $data['quantity'];
$total_price = $data['total_price'];
$name = $data['name'];
$address = $data['address'];
$phone = $data['phone'];
$latitude = $data['latitude'];
$longitude = $data['longitude'];

// Menyiapkan statement untuk mencegah SQL Injection
$stmt = $connect->prepare("INSERT INTO transactions (food_id, quantity, total_price, name, address, phone, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("iidsssss", $food_id, $quantity, $total_price, $name, $address, $phone, $latitude, $longitude);

// Menjalankan statement dan memeriksa apakah berhasil
if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => $stmt->error]);
}

// Menutup koneksi
$stmt->close();
$connect->close();
?>
