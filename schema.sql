DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_id INTEGER REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    category_id INTEGER NOT NULL REFERENCES categories(id) ON DELETE RESTRICT
);

CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL CHECK (quantity > 0)
);


INSERT INTO categories (id, name, parent_id) VALUES
(1, 'Бытовая техника', NULL),
(2, 'Компьютеры', NULL),
(3, 'Стиральные машины', 1),
(4, 'Холодильники', 1),
(5, 'Телевизоры', 1),
(6, 'Ноутбуки', 2),
(7, 'Моноблоки', 2),
(8, 'однокамерные', 4),
(9, 'двухкамерные', 4),
(10, '17"', 6),
(11, '19"', 6);

SELECT setval('categories_id_seq', (SELECT MAX(id) FROM categories));

INSERT INTO products (name, quantity, price, category_id) VALUES
('Bosch WAU28PH90E', 10, 35000.00, 3),
('Samsung WW90J54E0CW', 7, 29990.00, 3),
('Atlant ХМ 4208-031', 5, 18500.00, 8),
('LG GA-B489 UUQA', 4, 42000.00, 9),
('Samsung RB38T600ESA', 6, 38900.00, 9),
('Sony KD-55X80K', 8, 65000.00, 5),
('LG 43UQ75006LF', 12, 29990.00, 5),
('MSI Katana 17 B12VFK-2145XRU', 3, 120000.00, 10),
('ASUS ROG Strix SCAR 18', 2, 180000.00, 11),
('Apple iMac 24" M3', 5, 150000.00, 7),
('Lenovo IdeaCentre AIO 3', 6, 45000.00, 7);

INSERT INTO clients (name, address) VALUES
('ИП Сидоров А.В.', 'г. Москва, ул. Ленина, д. 10'),
('ООО "ТехноМир"', 'г. Санкт-Петербург, Невский пр., д. 45'),
('АО "Электроника Плюс"', 'г. Екатеринбург, ул. Малышева, д. 102'),
('Физическое лицо Петров И.И.', 'г. Новосибирск, ул. Советская, д. 7');

INSERT INTO orders (id, client_id, order_date) VALUES
(1, 1, '2025-10-01 10:30:00'),
(2, 2, '2025-10-03 14:15:00'),
(3, 1, '2025-10-05 09:45:00'),
(4, 3, '2025-10-07 16:20:00');

SELECT setval('orders_id_seq', (SELECT MAX(id) FROM orders));

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 6, 1),
(2, 4, 2),
(2, 8, 1),
(3, 10, 1),
(4, 2, 1),
(4, 5, 1),
(4, 7, 2),
(4, 9, 1);