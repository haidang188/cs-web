CREATE DATABASE phone_store;
USE phone_store;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100),
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255),
  phone VARCHAR(20),
  role ENUM('ADMIN','USER') DEFAULT 'USER',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);


CREATE TABLE brands (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);


CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  model VARCHAR(100) UNIQUE,
  category_id INT,
  brand_id INT,
  description TEXT,
  status ENUM('ACTIVE',  'INACTIVE') DEFAULT 'ACTIVE',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id),
  FOREIGN KEY (brand_id) REFERENCES brands(id)
  
);


CREATE TABLE product_variants (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  ram VARCHAR(50),
  storage VARCHAR(50),
  price DECIMAL(12,2),
  stock INT,

  FOREIGN KEY (product_id) REFERENCES products(id)
  ON DELETE CASCADE
);


CREATE TABLE product_images (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  image_url VARCHAR(500),
  is_primary BOOLEAN DEFAULT FALSE,

  FOREIGN KEY (product_id) REFERENCES products(id)
  ON DELETE CASCADE
);


CREATE TABLE carts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNIQUE,
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES users(id)
  ON DELETE CASCADE
);


CREATE TABLE cart_items (
  cart_id INT,
  variant_id INT,
  quantity INT,

  PRIMARY KEY (cart_id, variant_id),

  FOREIGN KEY (cart_id) REFERENCES carts(id),
  FOREIGN KEY (variant_id) REFERENCES product_variants(id)
  ON DELETE CASCADE
);


CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  total DECIMAL(12,2),
  status ENUM('PENDING','DONE','CANCEL') DEFAULT 'PENDING',
  address VARCHAR(255),
  phone VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  variant_id INT,
  product_name VARCHAR(255),
  ram VARCHAR(50),
  storage VARCHAR(50),
  price DECIMAL(12,2),
  quantity INT,

  FOREIGN KEY (order_id) REFERENCES orders(id)
  ON DELETE CASCADE
);

CREATE INDEX idx_product_brand
ON products(brand_id);

CREATE INDEX idx_product_category
ON products(category_id);

ALTER TABLE orders
ADD payment_method
VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;
UPDATE products
SET status = 1
WHERE status = 'ACTIVE';

UPDATE products
SET status = 0
WHERE status = 'INACTIVE';

ALTER TABLE products
MODIFY status BOOLEAN DEFAULT TRUE;

DESC products;