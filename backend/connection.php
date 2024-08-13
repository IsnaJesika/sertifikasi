<?php
$server = "localhost";
$user = "root";
$password = "";
$db= "sertifikasi_jmp";

$connect = new mysqli($server, $user, $password, $db);

if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}
?>
