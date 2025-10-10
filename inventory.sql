PRAGMA foreign_keys = ON;

CREATE TABLE Categories (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name TEXT NOT NULL,
    description TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Suppliers (
    supplier_id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_name TEXT NOT NULL,
    contact_person TEXT,
    phone TEXT,
    email TEXT,
    address TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_name TEXT NOT NULL,
    contact_person TEXT,
    phone TEXT,
    email TEXT,
    address TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Warehouses (
    warehouse_id INTEGER PRIMARY KEY AUTOINCREMENT,
    warehouse_name TEXT NOT NULL,
    location TEXT,
    capacity INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Items (
    item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    item_name TEXT NOT NULL,
    description TEXT,
    category_id INTEGER,
    supplier_id INTEGER,
    unit_price REAL,
    reorder_level INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE Stock (
    stock_id INTEGER PRIMARY KEY AUTOINCREMENT,
    item_id INTEGER,
    warehouse_id INTEGER,
    quantity INTEGER NOT NULL,
    last_updated TEXT DEFAULT CURRENT_TIMESTAMP,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES Items(item_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

CREATE TABLE PurchaseOrders (
    po_id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER,
    order_date TEXT,
    status TEXT,
    expected_delivery_date TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE PurchaseOrderDetails (
    po_detail_id INTEGER PRIMARY KEY AUTOINCREMENT,
    po_id INTEGER,
    item_id INTEGER,
    quantity_ordered INTEGER,
    unit_cost REAL,
    quantity_received INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (po_id) REFERENCES PurchaseOrders(po_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

CREATE TABLE SalesOrders (
    so_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    order_date TEXT,
    status TEXT,
    shipping_address TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE SalesOrderDetails (
    so_detail_id INTEGER PRIMARY KEY AUTOINCREMENT,
    so_id INTEGER,
    item_id INTEGER,
    quantity_sold INTEGER,
    unit_price REAL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (so_id) REFERENCES SalesOrders(so_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role TEXT,
    email TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Transactions (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    item_id INTEGER,
    transaction_type TEXT CHECK(transaction_type IN ('IN','OUT','ADJUSTMENT')) NOT NULL,
    quantity INTEGER,
    reference_id INTEGER,
    transaction_date TEXT DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES Items(item_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Categories (category_name, description) VALUES
('Bibs', 'Cycling bibs'),
('Jerseys', 'Cycling jerseys'),
('Shorts', 'Cycling shorts'),
('Gloves', 'Cycling gloves'),
('Helmets', 'Cycling helmets'),
('Shoes', 'Cycling shoes'),
('Accessories', 'Cycling accessories');

INSERT INTO Suppliers (supplier_name, contact_person, phone, email, address) VALUES
('Tech Supplies Inc.', 'Alice Smith', '123-456-7890', 'alice@techsupplies.com', '123 Tech Lane'),
('FurniCo', 'Bob Johnson', '234-567-8901', 'bob@furnico.com', '456 Furniture Ave');

INSERT INTO Customers (customer_name, contact_person, phone, email, address) VALUES
('Acme Corp', 'Carol White', '345-678-9012', 'carol@acmecorp.com', '789 Acme Blvd'),
('Beta LLC', 'David Brown', '456-789-0123', 'david@betallc.com', '101 Beta Rd');

INSERT INTO Warehouses (warehouse_name, location, capacity) VALUES
('Main Warehouse', 'Downtown', 1000),
('Secondary Warehouse', 'Uptown', 500);

INSERT INTO Items (item_name, description, category_id, supplier_id, unit_price, reorder_level) VALUES
('Linen Cloth', 'High-quality linen cloth', 1, 1, 800.00, 10),
('Cotton Fabric', 'Soft cotton fabric', 2, 2, 120.00, 5),
('Zips', 'Stainless Steel zippers', 3, 1, 2.50, 50);

INSERT INTO Stock (item_id, warehouse_id, quantity) VALUES
(1, 1, 20),
(2, 1, 15),
(3, 2, 200);

INSERT INTO PurchaseOrders (supplier_id, order_date, status, expected_delivery_date) VALUES
(1, '2025-10-01', 'Pending', '2025-10-10'),
(2, '2025-09-25', 'Received', '2025-09-30');

INSERT INTO PurchaseOrderDetails (po_id, item_id, quantity_ordered, unit_cost, quantity_received) VALUES
(1, 1, 10, 750.00, 0),
(2, 2, 5, 110.00, 5);

INSERT INTO SalesOrders (customer_id, order_date, status, shipping_address) VALUES
(1, '2025-10-03', 'Shipped', '789 Acme Blvd'),
(2, '2025-10-04', 'Pending', '101 Beta Rd');

INSERT INTO SalesOrderDetails (so_id, item_id, quantity_sold, unit_price) VALUES
(1, 1, 2, 850.00),
(2, 3, 10, 3.00);

INSERT INTO Users (username, password_hash, role, email) VALUES
('admin', 'hashedpassword1', 'admin', 'admin@example.com'),
('user1', 'hashedpassword2', 'staff', 'user1@example.com');

INSERT INTO Transactions (item_id, transaction_type, quantity, reference_id, user_id) VALUES
(1, 'IN', 10, 1, 1),
(2, 'OUT', 2, 1, 2),
(3, 'ADJUSTMENT', 5, NULL, 1);
