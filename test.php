<?php
echo "✅ Apache + PHP OK!<br><br>";

echo "MySQL Connection Test:<br>";
$host = getenv('DB_HOST') ?: 'localhost';
$user = getenv('DB_USER') ?: 'root';
$pass = getenv('DB_PASS') ?: '';
$db   = getenv('DB_NAME') ?: 'shoestore';

echo "DB_HOST: " . htmlspecialchars($host) . "<br>";
echo "DB_USER: " . htmlspecialchars($user) . "<br>";
echo "DB_NAME: " . htmlspecialchars($db) . "<br>";

try {
    $conn = new mysqli($host, $user, $pass, $db);
    if ($conn->connect_error) {
        echo "<br>❌ MySQL Error: " . htmlspecialchars($conn->connect_error);
    } else {
        echo "<br>✅ MySQL Connected!";
        $conn->close();
    }
} catch (Exception $e) {
    echo "<br>❌ Exception: " . htmlspecialchars($e->getMessage());
}
?>
