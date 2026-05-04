<?php
$host = getenv('DB_HOST') ?: 'localhost';
$user = getenv('DB_USER') ?: 'root';
$pass = getenv('DB_PASS') ?: '';
$db   = getenv('DB_NAME') ?: 'shoestore';

// Retry logic to handle MySQL startup delay
$conn = null;
$max_retries = 5;
$retry_count = 0;

while ($retry_count < $max_retries && !$conn) {
    try {
        $conn = new mysqli($host, $user, $pass, $db);
        if ($conn->connect_error) {
            throw new Exception($conn->connect_error);
        }
    } catch (Exception $e) {
        $retry_count++;
        if ($retry_count >= $max_retries) {
            die("Kết nối thất bại sau " . $max_retries . " lần thử: " . $e->getMessage());
        }
        sleep(2); // Wait 2 seconds before retry
    }
}

$conn->set_charset('utf8mb4');
$conn->query("SET NAMES utf8mb4");
$conn->query("SET CHARACTER SET utf8mb4");
