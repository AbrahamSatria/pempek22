-- Buat database
CREATE DATABASE IF NOT EXISTS pempek_tojotojo;
USE pempek_tojotojo;

-- Tabel users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    full_name VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel menu
CREATE TABLE menu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255),
    category VARCHAR(50),
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel orders
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_code VARCHAR(20) UNIQUE NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL,
    customer_email VARCHAR(100),
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'preparing', 'ready', 'completed', 'cancelled') DEFAULT 'pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    serving_type ENUM('Frozen', 'Siap Santap') DEFAULT 'Frozen'
);

-- Tabel order_items
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    menu_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu(id)
);

-- Insert sample users
INSERT INTO users (username, password, email, full_name, phone) VALUES
('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin@pempektojotojo.com', 'Administrator', '0895611067777'),
('customer', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'customer@example.com', 'Pelanggan Sample', '081234567890');

-- Insert menu items
INSERT INTO menu (name, description, price, image_url, category) VALUES
('Pempek Kapal Selam', 'Pempek dengan isian telur utuh yang lezat', 25000.00, 'https://tse4.mm.bing.net/th/id/OIP.5MEX4g-5zOHCptaiq5eU7wHaFP?pid=Api&P=0&h=220', 'pempek'),
('Pempek Adaan', 'Pempek bulat dengan tekstur yang kenyal', 9700.00, 'https://paxelmarket.co/wp-content/uploads/2022/02/96-20211015233453-Edit-600x600.jpg', 'pempek'),
('Pempek Kulit', 'Pempek dari bahan kulit ikan yang gurih', 9700.00, 'https://fs.genpi.co/uploads/news/2019/01/10/822919377cfd2531162213a8ca457477.jpg', 'pempek'),
('Pempek Lenjer', 'Pempek bentuk panjang tanpa isian', 9700.00, 'https://www.agoraliarecipes.com/wp-content/uploads/2022/06/AR00042-11.jpg', 'pempek'),
('Pempek Telor', 'Pempek dengan isian telur yang spesial', 9700.00, 'https://live.staticflickr.com/5083/5326090035_7c2ac2d41d_b.jpg', 'pempek');

-- Buat user untuk aplikasi (opsional)
CREATE USER 'pempek_user'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON pempek_tojotojo.* TO 'pempek_user'@'localhost';
FLUSH PRIVILEGES;