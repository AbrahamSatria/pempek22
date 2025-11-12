<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

$host = 'localhost';
$dbname = 'pempek_tojotojo';
$username = 'pempek_user';
$password = 'password123';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo json_encode(['error' => 'Database connection failed: ' . $e->getMessage()]);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
$input = json_decode(file_get_contents('php://input'), true);

switch($method) {
    case 'GET':
        if(isset($request[0]) && $request[0] == 'menu') {
            $stmt = $pdo->query("SELECT * FROM menu WHERE is_available = 1");
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($result);
        }
        break;
        
    case 'POST':
        if(isset($request[0]) && $request[0] == 'order') {
            $stmt = $pdo->prepare("INSERT INTO orders (order_code, customer_name, customer_phone, total_amount, notes, serving_type) VALUES (?, ?, ?, ?, ?, ?)");
            $order_code = 'ORDER-' . time() . '-' . rand(1000,9999);
            $stmt->execute([$order_code, $input['customerName'], $input['customerPhone'], $input['totalAmount'], $input['notes'], $input['servingType']]);
            
            $order_id = $pdo->lastInsertId();
            echo json_encode(['orderId' => $order_id, 'orderCode' => $order_code, 'success' => true]);
        }
        break;
}
?>