<?php
$host = getenv('DB_HOST') ?: 'localhost';
$user = getenv('DB_USER') ?: 'root';
$pass = getenv('DB_PASS') ?: '';
$db   = getenv('DB_NAME') ?: 'shoestore';

try {
    $conn = new mysqli($host, $user, $pass, $db);
    
    if ($conn->connect_error) {
        error_log("MySQL Error: " . $conn->connect_error);
        die("Kết nối database thất bại: " . $conn->connect_error);
    }
    
    $conn->set_charset('utf8mb4');
    $conn->query("SET NAMES utf8mb4");
    $conn->query("SET CHARACTER SET utf8mb4");
} catch (Exception $e) {
    error_log("Connection Exception: " . $e->getMessage());
    die("Kết nối thất bại: " . $e->getMessage());
}

$conn->set_charset('utf8mb4');
$conn->query("SET NAMES utf8mb4");
$conn->query("SET CHARACTER SET utf8mb4");
