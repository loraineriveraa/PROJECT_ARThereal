CREATE DATABASE IF NOT EXISTS arthereal_db;
USE arthereal_db;

-- USERS
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, 
    role ENUM('admin', 'artist', 'client') DEFAULT 'client',
    bio TEXT,
    profile_pic VARCHAR(255) DEFAULT 'default_avatar.png',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- USER ADDRESSES FOR SHIPPING (NO DATABASE YET)

-- CATEGORIES OF PRODUCTS (NO DATABASE YET)

-- ARTWORKS/PRODUCTS
CREATE TABLE IF NOT EXISTS artworks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL, 
    title VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(255) DEFAULT NULL, 
    category ENUM('Painting', 'Poster', 'Sticker', 'Keychain', 'Pin', 'Commission') NOT NULL,
    stock INT DEFAULT 1 CHECK (stock >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_category ON artworks(category);

-- ARTWORKS/PRODUCTS IMAGES (NO DATABASE YET)

-- INVENTORY (NO DATABASE YET)

-- SHOPPING CART
CREATE TABLE IF NOT EXISTS cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    artwork_id INT NOT NULL,
    quantity INT DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (artwork_id) REFERENCES artworks(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- CART ITEMS (NO DATABASE YET)

-- ORDERS
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    artist_id INT NOT NULL,
    artwork_id INT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'accepted', 'in progress', 'delivered', 'cancelled', 'refunded') DEFAULT 'pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE RESTRICT,
    FOREIGN KEY (artist_id) REFERENCES users(id) ON DELETE RESTRICT,
    FOREIGN KEY (artwork_id) REFERENCES artworks(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ORDER ITEMS TABLE (NO DATABASE YET)

-- PAYMENTS (NO DATABASE YET)

-- REVIEWS (NO DATABASE YET)

-- COUPONS/DISCOUNT (NO DATABASE YET)

-- ADD ALL NEEDED :') (DOUBLE CHECK FOR MISSING LATER)
