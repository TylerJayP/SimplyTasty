USE simplytasty;

DROP TABLE IF EXISTS Customer_DietaryPreference CASCADE;
DROP TABLE IF EXISTS Customer_OrderHistory CASCADE;
DROP TABLE IF EXISTS AirShipment CASCADE;
DROP TABLE IF EXISTS LandShipment CASCADE;
DROP TABLE IF EXISTS Recipe_DietaryOptions CASCADE;
DROP TABLE IF EXISTS Inventory CASCADE;
DROP TABLE IF EXISTS Recipe_Ingredients CASCADE;
DROP TABLE IF EXISTS DietaryOptions CASCADE;
DROP TABLE IF EXISTS MealKit_Ingredients CASCADE;
DROP TABLE IF EXISTS MealKit_Orders CASCADE;
DROP TABLE IF EXISTS MealKit CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Shipments CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS Recipe CASCADE;
DROP TABLE IF EXISTS Ingredient CASCADE;


-- Recipe Table
CREATE TABLE IF NOT EXISTS Recipe(
    Recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    Recipe_name VARCHAR(60) NOT NULL,
    Cuisine_type VARCHAR(60) DEFAULT NULL
);

-- Ingredient Table
CREATE TABLE IF NOT EXISTS Ingredient (
    ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(60) NOT NULL
);

-- Customer Table
CREATE TABLE IF NOT EXISTS Customer (
    Customer_id INT AUTO_INCREMENT PRIMARY KEY,
    First_name VARCHAR(80) NOT NULL,
    Last_name VARCHAR(80) NOT NULL,
    Address VARCHAR(50) DEFAULT NULL
);

-- Shipments Table
CREATE TABLE IF NOT EXISTS Shipments(
    Shipment_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Shipment_status VARCHAR(60),
    Shipment_date DATE DEFAULT NULL,
    Shipment_address VARCHAR(255),
    Destination_address VARCHAR(255),
    Customer_id INT,
    
    FOREIGN KEY(Customer_id) REFERENCES Customer(Customer_id)
);

-- LandShipment Table
CREATE TABLE IF NOT EXISTS LandShipment(
    Vehicle_type VARCHAR(50),
    Delivery_shipper_name VARCHAR(100),
    Shipment_id INT,
    
    FOREIGN KEY (Shipment_id) REFERENCES Shipments(Shipment_id)
);

-- AirShipment Table
CREATE TABLE IF NOT EXISTS AirShipment(
    Flight_num VARCHAR(50),
    Airline_name VARCHAR(100),
    Shipment_id INT,
    
    FOREIGN KEY (Shipment_id) REFERENCES Shipments(Shipment_id)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders(
    Order_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Order_price DECIMAL(5,2) NOT NULL,
    Order_date DATE DEFAULT NULL,
    Shipment_id INT,
    Customer_id INT,
    
    FOREIGN KEY (Shipment_id) REFERENCES Shipments(Shipment_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

-- Inventory Table
CREATE TABLE IF NOT EXISTS Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    ingredient_id INT,
    quantity INT NOT NULL,
    restock_date DATE,
    
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
);

-- MealKit Table
CREATE TABLE IF NOT EXISTS MealKit(
    Mealkit_id INT AUTO_INCREMENT PRIMARY KEY,
    Recipe_id INT,
    Customization_options INT DEFAULT NULL,
    
    FOREIGN KEY (Recipe_id) REFERENCES Recipe (Recipe_id) ON DELETE CASCADE
);

-- MealKit_Ingredients Table (Linking MealKit and Ingredients with Quantities)
CREATE TABLE IF NOT EXISTS MealKit_Ingredients (
    MealKit_id INT,
    Ingredient_id INT,
    Quantity INT,
    Unit VARCHAR(50),
    
    PRIMARY KEY (MealKit_id, Ingredient_id),
    FOREIGN KEY (MealKit_id) REFERENCES MealKit (Mealkit_id) ON DELETE CASCADE,
    FOREIGN KEY (Ingredient_id) REFERENCES Ingredient (ingredient_id) ON DELETE CASCADE
);

-- Recipe_Ingredients Table (Linking Recipe and Ingredients with Quantities)
CREATE TABLE IF NOT EXISTS Recipe_Ingredients (
    Recipe_id INT,
    Ingredient_id INT,
    Quantity INT,
    Unit VARCHAR(50),
    
    PRIMARY KEY (Recipe_id, Ingredient_id),
    FOREIGN KEY (Recipe_id) REFERENCES Recipe (Recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (Ingredient_id) REFERENCES Ingredient (ingredient_id) ON DELETE CASCADE
);

-- Create a table for dietary options
CREATE TABLE IF NOT EXISTS DietaryOptions (
    Dietary_options_id INT AUTO_INCREMENT PRIMARY KEY,
    Dietary_option_name VARCHAR(50) NOT NULL UNIQUE
);

-- Create a table to link recipes to dietary options
CREATE TABLE IF NOT EXISTS Recipe_DietaryOptions (
    Dietary_options_id INT,
    Recipe_id INT,
    
    PRIMARY KEY (Dietary_options_id, Recipe_id),
    FOREIGN KEY (Dietary_options_id) REFERENCES DietaryOptions(Dietary_options_id) ON DELETE CASCADE,
    FOREIGN KEY (Recipe_id) REFERENCES Recipe(Recipe_id) ON DELETE CASCADE
);

-- Customer_OrderHistory Table (Linking Customers and Orders)
CREATE TABLE IF NOT EXISTS Customer_OrderHistory (
    Customer_id INT,
    Order_id INT,
    
    PRIMARY KEY (Customer_id, Order_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE,
    FOREIGN KEY (Order_id) REFERENCES Orders(Order_id) ON DELETE CASCADE
);

-- Customer_DietaryPreference Table (Linking Customers and Dietary Preferences)
CREATE TABLE IF NOT EXISTS Customer_DietaryPreference (
    Customer_id INT,
    Dietary_options_id INT,
    
    PRIMARY KEY (Customer_id, Dietary_options_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE,
    FOREIGN KEY (Dietary_options_id) REFERENCES Recipe_DietaryOptions(Dietary_options_id) ON DELETE CASCADE
);

-- MealKit_Orders Table (Linking MealKit and Orders with Quantities)
CREATE TABLE IF NOT EXISTS MealKit_Orders (
    Order_id INT,
    Mealkit_id INT,
    Quantity INT,
    
    PRIMARY KEY (Order_id, Mealkit_id),
    FOREIGN KEY (Order_id) REFERENCES Orders (Order_id) ON DELETE CASCADE,
    FOREIGN KEY (Mealkit_id) REFERENCES MealKit (Mealkit_id) ON DELETE CASCADE
);


INSERT INTO Customer (First_name, Last_name, Address)
VALUES
    ('John', 'Doe', '123 Maple Rd, Rivertown'),
    ('Jane', 'Smith', '456 Oak St, Hilltop'),
    ('Emily', 'Johnson', '789 Birch Ln, Seaside'),
    ('Michael', 'Williams', '321 Pine Blvd, Lakeside'),
    ('Jessica', 'Brown', '908 Elm Rd, Meadowview'),
    ('James', 'Jones', '202 Walnut Ave, Riverdale'),
    ('Sarah', 'Miller', '14 Cherry Ct, Springtown'),
    ('David', 'Davis', '303 Cedar Ave, Forestville'),
    ('Laura', 'Martinez', '456 Oak St, Hilltop'),
    ('Daniel', 'Hernandez', '789 Birch Ln, Seaside'),
    ('Olivia', 'Lopez', '14 Cherry Ct, Springtown'),
    ('Ethan', 'Gonzalez', '123 Maple Rd, Rivertown'),
    ('Sophia', 'Perez', '321 Pine Blvd, Lakeside'),
    ('Benjamin', 'Taylor', '908 Elm Rd, Meadowview'),
    ('Charlotte', 'Anderson', '303 Cedar Ave, Forestville'),
    ('Alexander', 'Thomas', '202 Walnut Ave, Riverdale'),
    ('Amelia', 'Jackson', '456 Oak St, Hilltop'),
    ('William', 'White', '789 Birch Ln, Seaside'),
    ('Grace', 'Harris', '123 Maple Rd, Rivertown'),
    ('Jack', 'Clark', '14 Cherry Ct, Springtown'),
    ('Ella', 'Lewis', '908 Elm Rd, Meadowview'),
    ('Samuel', 'Walker', '321 Pine Blvd, Lakeside'),
    ('Mia', 'Hall', '456 Oak St, Hilltop'),
    ('Aiden', 'Young', '789 Birch Ln, Seaside'),
    ('Abigail', 'King', '14 Cherry Ct, Springtown'),
    ('Liam', 'Scott', '123 Maple Rd, Rivertown'),
    ('Chloe', 'Green', '202 Walnut Ave, Riverdale'),
    ('Jacob', 'Adams', '321 Pine Blvd, Lakeside'),
    ('Harper', 'Baker', '303 Cedar Ave, Forestville'),
    ('Michael', 'Nelson', '908 Elm Rd, Meadowview'),
    ('Isabella', 'Carter', '456 Oak St, Hilltop'),
    ('Lucas', 'Mitchell', '789 Birch Ln, Seaside'),
    ('Madison', 'Perez', '123 Maple Rd, Rivertown'),
    ('Charlotte', 'Roberts', '202 Walnut Ave, Riverdale'),
    ('Noah', 'Evans', '303 Cedar Ave, Forestville'),
    ('Zoe', 'Collins', '456 Oak St, Hilltop'),
    ('Elijah', 'Stewart', '321 Pine Blvd, Lakeside'),
    ('Harper', 'Morris', '908 Elm Rd, Meadowview'),
    ('Carter', 'Graham', '123 Maple Rd, Rivertown'),
    ('Leo', 'Foster', '202 Walnut Ave, Riverdale'),
    ('Sophie', 'Wright', '789 Birch Ln, Seaside'),
    ('Victoria', 'Hernandez', '456 Oak St, Hilltop'),
    ('Jackson', 'King', '321 Pine Blvd, Lakeside'),
    ('Eleanor', 'Lopez', '908 Elm Rd, Meadowview'),
    ('Henry', 'Hill', '303 Cedar Ave, Forestville'),
    ('Grace', 'Walker', '789 Birch Ln, Seaside'),
    ('Lily', 'Gonzalez', '123 Maple Rd, Rivertown'),
    ('Max', 'Martinez', '202 Walnut Ave, Riverdale'),
	('Mason', 'Bennett', '14 Cherry Ct, Springtown'),
    ('Evelyn', 'Rogers', '456 Oak St, Hilltop');
    
    
INSERT INTO Shipments (shipment_status, shipment_date, shipment_address, customer_id)
VALUES
	('Delivered', '2024-10-13', '123 Maple Rd, Rivertown', 1),
	('Shipped', '2024-09-28', '456 Oak St, Hilltop', 2),
	('In Transit', '2024-11-02', '789 Birch Ln, Seaside', 3),
	('Pending', '2024-10-05', '321 Pine Blvd, Lakeside', 4),
	('Delivered', '2024-10-17', '908 Elm Rd, Meadowview', 5),
	('Pending', '2024-10-20', '202 Walnut Ave, Riverdale', 6),
	('Shipped', '2024-09-22', '14 Cherry Ct, Springtown', 7),
	('In Transit', '2024-10-01', '456 Oak St, Hilltop', 8),
	('Delivered', '2024-10-25', '908 Elm Rd, Meadowview', 9),
	('Pending', '2024-09-30', '303 Cedar Ave, Forestville', 10),
	('Shipped', '2024-10-12', '202 Walnut Ave, Riverdale', 11),
	('In Transit', '2024-10-23', '14 Cherry Ct, Springtown', 12),
	('Delivered', '2024-09-17', '123 Maple Rd, Rivertown', 13),
	('Pending', '2024-10-11', '789 Birch Ln, Seaside', 14),
	('Shipped', '2024-10-06', '303 Cedar Ave, Forestville', 15),
	('In Transit', '2024-11-03', '14 Cherry Ct, Springtown', 16),
	('Delivered', '2024-10-03', '456 Oak St, Hilltop', 17),
	('Pending', '2024-10-21', '908 Elm Rd, Meadowview', 18),
	('Shipped', '2024-10-19', '202 Walnut Ave, Riverdale', 19),
	('In Transit', '2024-10-28', '321 Pine Blvd, Lakeside', 20),
	('Delivered', '2024-10-14', '303 Cedar Ave, Forestville', 21),
	('Shipped', '2024-09-27', '789 Birch Ln, Seaside', 22),
	('In Transit', '2024-11-06', '123 Maple Rd, Rivertown', 23),
	('Pending', '2024-10-18', '14 Cherry Ct, Springtown', 24),
	('Delivered', '2024-10-02', '456 Oak St, Hilltop', 25),
	('Shipped', '2024-10-15', '202 Walnut Ave, Riverdale', 26),
	('Pending', '2024-09-26', '321 Pine Blvd, Lakeside', 27),
	('In Transit', '2024-10-09', '789 Birch Ln, Seaside', 28),
	('Delivered', '2024-09-23', '303 Cedar Ave, Forestville', 29),
	('Shipped', '2024-10-10', '14 Cherry Ct, Springtown', 30),
	('In Transit', '2024-11-01', '908 Elm Rd, Meadowview', 31),
	('Delivered', '2024-09-29', '123 Maple Rd, Rivertown', 32),
	('Pending', '2024-10-22', '456 Oak St, Hilltop', 33),
	('Shipped', '2024-10-24', '789 Birch Ln, Seaside', 34),
	('In Transit', '2024-10-30', '303 Cedar Ave, Forestville', 35),
	('Delivered', '2024-09-18', '202 Walnut Ave, Riverdale', 36),
	('Pending', '2024-10-16', '321 Pine Blvd, Lakeside', 37),
	('Shipped', '2024-10-08', '908 Elm Rd, Meadowview', 38),
	('In Transit', '2024-09-24', '123 Maple Rd, Rivertown', 39),
	('Delivered', '2024-10-04', '14 Cherry Ct, Springtown', 40),
	('Pending', '2024-10-29', '456 Oak St, Hilltop', 41),
	('Shipped', '2024-09-25', '789 Birch Ln, Seaside', 42),
	('In Transit', '2024-10-07', '202 Walnut Ave, Riverdale', 43),
	('Delivered', '2024-10-18', '321 Pine Blvd, Lakeside', 44),
	('Shipped', '2024-11-04', '303 Cedar Ave, Forestville', 45),
	('In Transit', '2024-09-20', '14 Cherry Ct, Springtown', 46),
	('Pending', '2024-10-31', '123 Maple Rd, Rivertown', 47),
	('Shipped', '2024-10-27', '908 Elm Rd, Meadowview', 48),
	('In Transit', '2024-10-24', '456 Oak St, Hilltop', 49),
	('Delivered', '2024-09-19', '789 Birch Ln, Seaside', 50);


INSERT INTO Orders (Order_price, Order_date, Shipment_id, Customer_id) 
VALUES
	(145.55, '2024-08-17', 37, 1),(233.75, '2024-05-23', 19, 2),
	(58.99, '2024-07-11', 25, 3), (177.60, '2024-09-06', 18, 4), (89.99, '2024-03-28', 32, 5), (204.50, '2024-01-15', 7, 6),
	(120.33, '2024-10-20', 33, 7), (95.10, '2024-06-30', 46, 8), (179.99, '2024-12-02', 9, 9), (67.80, '2024-04-25', 5, 10),
	(205.45, '2024-11-07', 30, 11), (115.95, '2024-02-19', 12, 12), (210.20, '2024-10-04', 28, 13), (85.50, '2024-08-12', 50, 14),
	(134.00, '2024-07-17', 3, 15), (159.75, '2024-09-13', 44, 16), (198.50, '2024-11-21', 19, 17), (75.60, '2024-01-07', 29, 18),
	(189.20, '2024-03-15', 5, 19), (159.80, '2024-12-18', 26, 20), (99.00, '2024-05-04', 33, 21), (165.30, '2024-09-22', 21, 22),
	(210.00, '2024-06-14', 24, 23), (179.45, '2024-10-10', 7, 24), (55.60, '2024-02-23', 50, 25), (140.90, '2024-11-28', 18, 26),
	(133.45, '2024-07-25', 9, 27), (125.75, '2024-05-16', 17, 28), (179.30, '2024-01-21', 12, 29), (50.80, '2024-12-05', 27, 30),
	(98.65, '2024-08-03', 8, 31), (210.55, '2024-10-15', 35, 32), (115.60, '2024-04-06', 4, 33), (195.50, '2024-11-11', 6, 34),
	(200.00, '2024-06-03', 29, 35), (140.75, '2024-09-19', 24, 36), (130.90, '2024-03-01', 11, 37), (160.00, '2024-01-28', 22, 38),
	(198.99, '2024-07-02', 38, 39), (160.25, '2024-12-14', 16, 40), (105.50, '2024-02-08', 14, 41), (87.75, '2024-09-04', 5, 42),
	(170.00, '2024-10-22', 19, 43), (125.10, '2024-08-21', 21, 44), (149.95, '2024-06-25', 37, 45), (195.20, '2024-11-17', 12, 46),
	(135.45, '2024-05-07', 33, 47), (75.80, '2024-12-11', 25, 48), (111.10, '2024-03-06', 17, 49), (142.90, '2024-01-02', 8, 50);


INSERT INTO AirShipment (Flight_num, Airline_name, Shipment_id) 
VALUES
	('DL523', 'Delta Airlines', 27), ('AA894', 'American Airlines', 13), ('AF601', 'Air France', 40),
	('UA311', 'United Airlines', 9), ('SW209', 'Southwest Airlines', 16), ('AL778', 'Alaska Airlines', 30),
	('AA456', 'American Airlines', 22), ('UA549', 'United Airlines', 2), ('SW101', 'Southwest Airlines', 38),
	('DL249', 'Delta Airlines', 44), ('AF935', 'Air France', 14), ('UA725', 'United Airlines', 1),
	('AA671', 'American Airlines', 47), ('AL882', 'Alaska Airlines', 25), ('DL350', 'Delta Airlines', 33),
	('SW315', 'Southwest Airlines', 12), ('AF804', 'Air France', 49), ('UA643', 'United Airlines', 5),
	('AA211', 'American Airlines', 21), ('AL456', 'Alaska Airlines', 19), ('SW876', 'Southwest Airlines', 29),
	('AF501', 'Air France', 46), ('UA412', 'United Airlines', 15), ('DL800', 'Delta Airlines', 8),
	('AA319', 'American Airlines', 50), ('AF724', 'Air France', 7), ('UA162', 'United Airlines', 32),
	('SW214', 'Southwest Airlines', 39), ('AL229', 'Alaska Airlines', 24), ('DL333', 'Delta Airlines', 11),
	('AA123', 'American Airlines', 43), ('AF295', 'Air France', 28), ('UA545', 'United Airlines', 10),
	('SW908', 'Southwest Airlines', 6), ('AL550', 'Alaska Airlines', 36), ('DL572', 'Delta Airlines', 18),
	('AA738', 'American Airlines', 34), ('AF180', 'Air France', 31), ('UA115', 'United Airlines', 26),
	('SW631', 'Southwest Airlines', 45), ('AL992', 'Alaska Airlines', 23), ('DL925', 'Delta Airlines', 41),
	('AA957', 'American Airlines', 20), ('AF889', 'Air France', 4), ('UA663', 'United Airlines', 48),
	('SW404', 'Southwest Airlines', 37), ('AL238', 'Alaska Airlines', 17), ('DL189', 'Delta Airlines', 42),
	('AA671', 'American Airlines', 3);


INSERT INTO LandShipment (Vehicle_type, Delivery_shipper_name, Shipment_id) 
VALUES
	('Cargo Van', 'QuickMove Logistics', 37), ('Van', 'Express Freight', 44),
	('Truck', 'Speedy Shipping Co.', 18), ('Cargo Van', 'Reliable Transport', 25),
	('Truck', 'FastTrack Logistics', 19), ('Van', 'Swift Deliveries', 1),
	('Cargo Van', 'Speedy Freight', 32), ('Van', 'Reliable Movers', 48),
	('Truck', 'QuickMove Logistics', 33), ('Cargo Van', 'MoveFast Delivery', 30),
	('Van', 'Swift Freight', 46), ('Truck', 'QuickTrack Shipping', 9),
	('Cargo Van', 'Express Freight', 5), ('Van', 'Speedy Shipping Co.', 12),
	('Truck', 'On-Time Delivery', 40), ('Cargo Van', 'Reliable Transport', 7),
	('Van', 'Swift Logistics', 36), ('Truck', 'Fast Freight Solutions', 43),
	('Cargo Van', 'MoveFast Delivery', 3), ('Van', 'Swift Deliveries', 49),
	('Truck', 'Reliable Movers', 20), ('Cargo Van', 'Express Logistics', 29),
	('Van', 'QuickMove Logistics', 24), ('Truck', 'Speedy Freight', 4),
	('Cargo Van', 'On-Time Delivery', 34), ('Van', 'Speedy Shipping Co.', 50),
	('Truck', 'Rapid Shippers', 6), ('Cargo Van', 'Swift Freight', 31),
	('Van', 'Express Freight', 8), ('Truck', 'FastTrack Logistics', 13),
	('Cargo Van', 'Reliable Transport', 2), ('Van', 'MoveFast Delivery', 26),
	('Truck', 'On-Time Delivery', 16), ('Cargo Van', 'Express Freight', 22),
	('Van', 'Swift Logistics', 39), ('Truck', 'QuickMove Logistics', 45),
	('Cargo Van', 'Reliable Transport', 28), ('Van', 'MoveFast Delivery', 41),
	('Truck', 'Speedy Freight Solutions', 10), ('Cargo Van', 'Swift Freight', 11),
	('Van', 'QuickTrack Shipping', 14), ('Truck', 'Reliable Movers', 21),
	('Cargo Van', 'Speedy Shipping Co.', 38), ('Van', 'Express Freight', 17),
	('Truck', 'FastTrack Logistics', 15), ('Cargo Van', 'MoveFast Delivery', 23),
	('Van', 'Reliable Transport', 42), ('Truck', 'Swift Freight', 35);


INSERT INTO Ingredient (item_name) 
VALUES 
	('Tomato'), ('Onion'), ('Garlic'), ('Carrot'), ('Bell Pepper'),
	('Potato'), ('Cucumber'), ('Spinach'), ('Broccoli'), ('Lettuce'),
	('Chicken'), ('Beef'), ('Pork'), ('Fish'), ('Shrimp'),
	('Salt'), ('Pepper'), ('Olive Oil'), ('Butter'), ('Milk'),
	('Eggs'), ('Cheese'), ('Yogurt'), ('Flour'), ('Sugar'),
	('Rice'), ('Pasta'), ('Beans'), ('Lentils'), ('Chickpeas'),
	('Basil'), ('Thyme'), ('Parsley'), ('Cinnamon'), ('Vanilla'),
	('Oats'), ('Bread'), ('Tofu'), ('Soy Sauce'), ('Tomato Sauce'),
	('Honey'), ('Almonds'), ('Walnuts'), ('Peanut Butter'), ('Chocolate'),
	('Orange'), ('Apple'), ('Banana'), ('Strawberry'), ('Blueberry');


INSERT INTO Inventory (ingredient_id, quantity, restock_date) 
VALUES 
	(1, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(2, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(3, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(4, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(5, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(6, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(7, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(8, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(9, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(10, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(11, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(12, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(13, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(14, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(15, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(16, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(17, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(18, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(19, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(20, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(21, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(22, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(23, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(24, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(25, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(26, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(27, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(28, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(29, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(30, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(31, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(32, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(33, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(34, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(35, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(36, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(37, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(38, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(39, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(40, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(41, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(42, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(43, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(44, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(45, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(46, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(47, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(48, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(49, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)),
	(50, FLOOR(RAND() * 100 + 1), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY));
    
    
INSERT INTO Recipe (Recipe_name, Cuisine_type) 
VALUES
	('Tomato Basil Soup', 'Italian'),
	('Beef Stew', 'American'),
	('Chicken Stir Fry', 'Chinese'),
	('Grilled Shrimp Salad', 'Mediterranean'),
	('Vegetable Curry', 'Indian'),
	('Garlic Butter Chicken', 'American'),
	('Egg Salad', 'American'),
	('Pasta Primavera', 'Italian'),
	('Chicken Tacos', 'Mexican'),
	('Spaghetti Bolognese', 'Italian'),
	('Roasted Vegetables', 'Mediterranean'),
	('Lentil Soup', 'Middle Eastern'),
	('Crispy Fish Tacos', 'Mexican'),
	('Chicken Alfredo', 'Italian'),
	('Tofu Stir Fry', 'Asian'),
	('Beef Tacos', 'Mexican'),
	('Pork Chops with Apples', 'American'),
	('Vegetable Stir Fry', 'Chinese'),
	('Minestrone Soup', 'Italian'),
	('BBQ Chicken', 'American'),
	('Shrimp Scampi', 'Italian'),
	('Omelette', 'French'),
	('Grilled Vegetables', 'Mediterranean'),
	('Banana Pancakes', 'American'),
	('Tomato Cucumber Salad', 'Mediterranean'),
	('Chicken Caesar Salad', 'American'),
	('Pasta Carbonara', 'Italian'),
	('Apple Cinnamon Oatmeal', 'American'),
	('Vegetable Quesadilla', 'Mexican'),
	('Beef Burritos', 'Mexican'),
	('Crispy Chicken Sandwich', 'American'),
	('Cheese Omelette', 'American'),
	('Baked Potatoes with Cheese', 'American'),
	('Garlic Bread', 'Italian'),
	('Roast Chicken', 'American'),
	('Fried Rice', 'Chinese'),
	('Pasta with Tomato Sauce', 'Italian'),
	('Chicken Parmesan', 'Italian'),
	('Grilled Chicken Sandwich', 'American'),
	('Vegetable Soup', 'American'),
	('Chocolate Chip Cookies', 'American'),
	('Pork Stir Fry', 'Asian'),
	('Tomato Sauce Pasta', 'Italian'),
	('Stuffed Bell Peppers', 'American'),
	('Cinnamon Rolls', 'American'),
	('Banana Bread', 'American'),
	('Steak with Garlic Butter', 'American'),
	('Roast Beef Sandwich', 'American'),
	('Eggplant Parmesan', 'Italian'),
	('Chickpea Salad', 'Mediterranean'),
	('Sweet Potato Fries', 'American'),
	('Vegetable Frittata', 'Italian'),
	('Oats and Honey Breakfast', 'American'),
	('Shrimp and Grits', 'Southern');


INSERT INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit) 
VALUES
    (1, 1, 2, 'cups'),  -- Tomato Basil Soup
    (1, 29, 1, 'tbsp'),  -- Tomato Basil Soup
    (2, 13, 2, 'lbs'),  -- Beef Stew
    (2, 6, 1, 'cup'),  -- Beef Stew
    (3, 12, 1, 'lbs'),  -- Chicken Stir Fry
    (3, 17, 1, 'tbsp'),  -- Chicken Stir Fry
    (4, 14, 1, 'lbs'),  -- Grilled Shrimp Salad
    (4, 10, 2, 'cups'),  -- Grilled Shrimp Salad
    (5, 22, 1, 'can'),  -- Vegetable Curry
    (5, 11, 1, 'cup'),  -- Vegetable Curry
    (6, 12, 1, 'lbs'),  -- Garlic Butter Chicken
    (6, 17, 3, 'tbsp'),  -- Garlic Butter Chicken
    (7, 19, 4, 'eggs'),  -- Egg Salad
    (7, 16, 1, 'tbsp'),  -- Egg Salad
    (8, 24, 1, 'lb'),  -- Pasta Primavera
    (8, 23, 1, 'cup'),  -- Pasta Primavera
    (9, 12, 1, 'lbs'),  -- Chicken Tacos
    (9, 19, 2, 'tbsp'),  -- Chicken Tacos
    (10, 24, 1, 'lbs'),  -- Spaghetti Bolognese
    (10, 1, 1, 'cup'),  -- Spaghetti Bolognese
    (11, 22, 1, 'cup'),  -- Roasted Vegetables
    (11, 1, 1, 'tbsp'),  -- Roasted Vegetables
    (12, 27, 1, 'cup'),  -- Lentil Soup
    (12, 7, 1, 'cup'),  -- Lentil Soup
    (13, 14, 1, 'lbs'),  -- Crispy Fish Tacos
    (13, 19, 2, 'tbsp'),  -- Crispy Fish Tacos
    (14, 12, 1, 'lbs'),  -- Chicken Alfredo
    (14, 24, 1, 'cup'),  -- Chicken Alfredo
    (15, 29, 1, 'block'),  -- Tofu Stir Fry
    (15, 6, 1, 'tbsp'),  -- Tofu Stir Fry
    (16, 13, 1, 'lbs'),  -- Beef Tacos
    (16, 5, 1, 'tbsp'),  -- Beef Tacos
    (17, 15, 2, 'chops'),  -- Pork Chops with Apples
    (17, 30, 1, 'apple'),  -- Pork Chops with Apples
    (18, 22, 2, 'cups'),  -- Vegetable Stir Fry
    (18, 6, 1, 'tbsp'),  -- Vegetable Stir Fry
    (19, 27, 1, 'cup'),  -- Minestrone Soup
    (19, 3, 2, 'cloves'),  -- Minestrone Soup
    (20, 12, 1, 'lbs'),  -- BBQ Chicken
    (20, 17, 3, 'tbsp'),  -- BBQ Chicken
    (21, 14, 1, 'lbs'),  -- Shrimp Scampi
    (21, 16, 1, 'tbsp'),  -- Shrimp Scampi
    (22, 19, 3, 'eggs'),  -- Omelette
    (22, 29, 1, 'tbsp'),  -- Omelette
    (23, 22, 2, 'cups'),  -- Grilled Vegetables
    (23, 10, 2, 'tbsp'),  -- Grilled Vegetables
    (24, 30, 1, 'banana'),  -- Banana Pancakes
    (24, 26, 1, 'cup'),  -- Banana Pancakes
    (25, 1, 1, 'cup'),  -- Tomato Cucumber Salad
    (25, 7, 1, 'cup'),  -- Tomato Cucumber Salad
    (26, 12, 1, 'lbs'),  -- Chicken Caesar Salad
    (26, 24, 2, 'tbsp'),  -- Chicken Caesar Salad
    (27, 24, 1, 'cup'),  -- Pasta Carbonara
    (27, 10, 1, 'cup'),  -- Pasta Carbonara
    (28, 19, 1, 'tbsp'),  -- Apple Cinnamon Oatmeal
    (28, 27, 1, 'apple'),  -- Apple Cinnamon Oatmeal
    (29, 22, 1, 'cup'),  -- Vegetable Quesadilla
    (29, 5, 1, 'cup'),  -- Vegetable Quesadilla
    (30, 13, 1, 'lbs'),  -- Beef Burritos
    (30, 3, 1, 'cup'),  -- Beef Burritos
    (31, 12, 1, 'lbs'),  -- Crispy Chicken Sandwich
    (31, 17, 1, 'tbsp'),  -- Crispy Chicken Sandwich
    (32, 19, 3, 'eggs'),  -- Cheese Omelette
    (32, 24, 1, 'cup'),  -- Cheese Omelette
    (33, 26, 2, 'potatoes'),  -- Baked Potatoes with Cheese
    (33, 24, 1, 'cup'),  -- Baked Potatoes with Cheese
    (34, 1, 2, 'cloves'),  -- Garlic Bread
    (34, 24, 1, 'tbsp'),  -- Garlic Bread
    (35, 12, 1, 'lbs'),  -- Roast Chicken
    (35, 17, 3, 'tbsp'),  -- Roast Chicken
    (36, 6, 1, 'tbsp'),  -- Fried Rice
    (36, 23, 1, 'cup'),  -- Fried Rice
    (37, 1, 1, 'cup'),  -- Pasta with Tomato Sauce
    (37, 22, 1, 'tbsp'),  -- Pasta with Tomato Sauce
    (38, 12, 1, 'lbs'),  -- Chicken Parmesan
    (38, 19, 3, 'tbsp');  -- Chicken Parmesan
   
   
INSERT INTO DietaryOptions (Dietary_option_name)
VALUES
    ('Vegetarian'), ('Vegan'), ('Gluten-Free'),
    ('Dairy-Free'), ('Low Carb'), ('Low Fat'),
    ('Keto'), ('Paleo'), ('Nut-Free'),
    ('Halal'), ('Kosher'),('Organic');


INSERT INTO Recipe_DietaryOptions (Dietary_options_id, Recipe_id)
VALUES
    (1, 1), (2, 1), -- Recipe 1 linked to Vegetarian and Vegan
    (3, 2), -- Recipe 2 linked to Gluten-Free
    (4, 3), -- Recipe 3 linked to Dairy-Free
    (5, 4), (6, 4), -- Recipe 4 linked to Low Carb and Low Fat
    (7, 5), -- Recipe 5 linked to Keto
    (8, 6), -- Recipe 6 linked to Paleo
    (9, 7), (10, 7), -- Recipe 7 linked to Nut-Free and Halal
    (11, 8), -- Recipe 8 linked to Kosher
    (12, 9), -- Recipe 9 linked to Organic
    (1, 10), (2, 10), (5, 10), -- Recipe 10 linked to Vegetarian, Vegan, and Low Carb
    (6, 11), -- Recipe 11 linked to Low Fat
    (3, 12), (8, 12), -- Recipe 12 linked to Dairy-Free and Paleo
    (4, 13), -- Recipe 13 linked to Dairy-Free
    (9, 14), -- Recipe 14 linked to Organic
    (10, 15), -- Recipe 15 linked to Halal
    (2, 16), -- Recipe 16 linked to Vegan
    (7, 17), -- Recipe 17 linked to Keto
    (5, 18), (8, 18), -- Recipe 18 linked to Low Carb and Paleo
    (6, 19), -- Recipe 19 linked to Low Fat
    (1, 20), -- Recipe 20 linked to Vegetarian
    (12, 21), -- Recipe 21 linked to Organic
    (4, 22), (7, 22), -- Recipe 22 linked to Dairy-Free and Keto
    (3, 23), (8, 23), -- Recipe 23 linked to Gluten-Free and Paleo
    (9, 24), -- Recipe 24 linked to Nut-Free
    (10, 25), -- Recipe 25 linked to Halal
    (11, 26), -- Recipe 26 linked to Kosher
    (2, 27), -- Recipe 27 linked to Vegan
    (12, 28), -- Recipe 28 linked to Organic
    (7, 29), (5, 29), -- Recipe 29 linked to Keto and Low Carb
    (6, 30), -- Recipe 30 linked to Low Fat
    (4, 31), -- Recipe 31 linked to Dairy-Free
    (9, 32), -- Recipe 32 linked to Nut-Free
    (10, 33), -- Recipe 33 linked to Halal
    (3, 34), -- Recipe 34 linked to Gluten-Free
    (8, 35), -- Recipe 35 linked to Paleo
    (1, 36), -- Recipe 36 linked to Vegetarian
    (12, 37), -- Recipe 37 linked to Organic
    (4, 38), -- Recipe 38 linked to Dairy-Free
    (5, 39), -- Recipe 39 linked to Low Carb
    (7, 40), -- Recipe 40 linked to Keto
    (6, 41), -- Recipe 41 linked to Low Fat
    (11, 42), -- Recipe 42 linked to Kosher
    (3, 43), -- Recipe 43 linked to Gluten-Free
    (8, 44), -- Recipe 44 linked to Paleo
    (1, 45), (7, 45), -- Recipe 45 linked to Vegetarian and Keto
    (9, 46), -- Recipe 46 linked to Nut-Free
    (2, 47), -- Recipe 47 linked to Vegan
    (12, 48), -- Recipe 48 linked to Organic
    (6, 49), -- Recipe 49 linked to Low Fat
    (4, 50), -- Recipe 50 linked to Dairy-Free
    (10, 51), -- Recipe 51 linked to Halal
    (7, 52), -- Recipe 52 linked to Keto
    (3, 53), -- Recipe 53 linked to Gluten-Free
    (5, 54), (9, 54); -- Recipe 54 linked to Low Carb and Nut-Free
 
 
INSERT INTO MealKit (Recipe_id, Customization_options) 
VALUES 
    (1, NULL), (2, 1), (3, 2), (4, 3), (5, NULL), 
    (6, 4), (7, 5), (8, NULL), (9, 6), (10, 7), 
    (11, 8), (12, 9), (13, NULL), (14, 10), (15, 11), 
    (16, NULL), (17, 12), (18, 13), (19, NULL), (20, 14), 
    (21, 15), (22, 16), (23, NULL), (24, 17), (25, 18), 
    (26, NULL), (27, 19), (28, 20), (29, NULL), (30, 21), 
    (31, NULL), (32, 22), (33, 23), (34, NULL), (35, 24), 
    (36, 25), (37, 26), (38, NULL), (39, 27), (40, 28), 
    (41, NULL), (42, 29), (43, 30), (44, NULL), (45, 31), 
    (46, 32), (47, NULL), (48, 33), (49, 34), (50, NULL);


INSERT INTO MealKit_Ingredients (MealKit_id, Ingredient_id, Quantity, Unit) 
VALUES 
    (1, 1, 2, 'Tomatoes'),
    (1, 2, 1, 'Onion'),
    (1, 3, 3, 'Garlic Cloves'),
    (2, 5, 1, 'Bell Pepper'),
    (2, 6, 3, 'Potatoes'),
    (2, 7, 2, 'Cucumbers'),
    (3, 9, 1, 'Broccoli'),
    (3, 10, 5, 'Lettuce'),
    (3, 4, 2, 'Carrots'),
    (4, 11, 1, 'Chicken Breast'),
    (4, 12, 2, 'Beef Steaks'),
    (4, 13, 3, 'Pork Chops'),
    (5, 14, 1, 'Fish Fillet'),
    (5, 15, 4, 'Shrimp'),
    (5, 16, 3, 'Salt'),
    (6, 17, 1, 'Pepper'),
    (6, 18, 2, 'Olive Oil'),
    (7, 19, 1, 'Butter'),
    (7, 20, 1, 'Milk'),
    (7, 21, 3, 'Eggs'),
    (8, 22, 2, 'Cheese'),
    (8, 23, 1, 'Yogurt'),
    (9, 24, 2, 'Flour'),
    (9, 25, 3, 'Sugar'),
    (10, 26, 1, 'Rice'),
    (10, 27, 2, 'Pasta'),
    (11, 28, 1, 'Beans'),
    (12, 29, 1, 'Lentils'),
    (12, 30, 1, 'Chickpeas'),
    (13, 31, 1, 'Basil'),
    (13, 32, 3, 'Thyme'),
    (14, 33, 4, 'Parsley'),
    (15, 34, 2, 'Cinnamon'),
    (15, 35, 1, 'Vanilla Extract'),
    (16, 36, 5, 'Oats'),
    (16, 37, 2, 'Bread'),
    (17, 38, 1, 'Tofu'),
    (18, 39, 1, 'Soy Sauce'),
    (19, 40, 1, 'Tomato Sauce'),
    (20, 41, 1, 'Honey'),
    (20, 42, 2, 'Almonds'),
    (21, 43, 1, 'Walnuts'),
    (22, 44, 2, 'Peanut Butter'),
    (22, 45, 3, 'Chocolate'),
    (23, 46, 1, 'Orange'),
    (24, 47, 2, 'Apple'),
    (24, 48, 1, 'Banana'),
    (25, 49, 5, 'Strawberries'),
    (25, 50, 2, 'Blueberries'),
    (26, 1, 3, 'Tomatoes'),
    (26, 3, 2, 'Garlic Cloves'),
    (27, 5, 1, 'Bell Pepper'),
    (28, 6, 3, 'Potatoes'),
    (29, 10, 5, 'Lettuce'),
    (30, 13, 3, 'Pork Chops'),
    (31, 18, 1, 'Olive Oil'),
    (32, 22, 2, 'Cheese'),
    (33, 23, 1, 'Yogurt');


INSERT INTO MealKit_Orders (Order_id, Mealkit_id, Quantity)
VALUES
    (1, 1, 2),  -- Order 1 includes 2 units of MealKit 1
    (1, 3, 1),  -- Order 1 includes 1 unit of MealKit 3
    (2, 2, 4),  -- Order 2 includes 4 units of MealKit 2
    (2, 4, 2),  -- Order 2 includes 2 units of MealKit 4
    (3, 5, 1),  -- Order 3 includes 1 unit of MealKit 5
    (3, 7, 3),  -- Order 3 includes 3 units of MealKit 7
    (4, 6, 5),  -- Order 4 includes 5 units of MealKit 6
    (4, 8, 2),  -- Order 4 includes 2 units of MealKit 8
    (5, 9, 6),  -- Order 5 includes 6 units of MealKit 9
    (5, 10, 3), -- Order 5 includes 3 units of MealKit 10
    (6, 1, 4),  -- Order 6 includes 4 units of MealKit 1
    (6, 2, 2),  -- Order 6 includes 2 units of MealKit 2
    (7, 3, 1),  -- Order 7 includes 1 unit of MealKit 3
    (7, 4, 3),  -- Order 7 includes 3 units of MealKit 4
    (8, 5, 7),  -- Order 8 includes 7 units of MealKit 5
    (8, 6, 2),  -- Order 8 includes 2 units of MealKit 6
    (9, 7, 4),  -- Order 9 includes 4 units of MealKit 7
    (9, 8, 1),  -- Order 9 includes 1 unit of MealKit 8
    (10, 9, 2), -- Order 10 includes 2 units of MealKit 9
    (10, 10, 5), -- Order 10 includes 5 units of MealKit 10
    (11, 1, 3),  -- Order 11 includes 3 units of MealKit 1
    (11, 3, 4),  -- Order 11 includes 4 units of MealKit 3
    (12, 2, 6),  -- Order 12 includes 6 units of MealKit 2
    (12, 4, 2),  -- Order 12 includes 2 units of MealKit 4
    (13, 5, 3),  -- Order 13 includes 3 units of MealKit 5
    (13, 6, 1),  -- Order 13 includes 1 unit of MealKit 6
    (14, 7, 5),  -- Order 14 includes 5 units of MealKit 7
    (14, 8, 3),  -- Order 14 includes 3 units of MealKit 8
    (15, 9, 1),  -- Order 15 includes 1 unit of MealKit 9
    (15, 10, 6); -- Order 15 includes 6 units of MealKit 10

INSERT INTO Customer_DietaryPreference (Customer_id, Dietary_options_id)
VALUES
    (1, 1), (1, 3), -- Customer 1 prefers Vegetarian and Gluten-Free
    (2, 2),          -- Customer 2 prefers Vegan
    (3, 5),          -- Customer 3 prefers Dairy-Free
    (4, 4),          -- Customer 4 prefers Nut-Free
    (5, 6), (5, 8),  -- Customer 5 prefers Keto and Paleo
    (6, 7),          -- Customer 6 prefers Low-Carb
    (7, 2), (7, 3),  -- Customer 7 prefers Vegan and Gluten-Free
    (8, 1),          -- Customer 8 prefers Vegetarian
    (9, 5),          -- Customer 9 prefers Dairy-Free
    (10, 9),         -- Customer 10 prefers Halal
    (11, 6), (11, 8), -- Customer 11 prefers Keto and Paleo
    (12, 3),         -- Customer 12 prefers Gluten-Free
    (13, 2),         -- Customer 13 prefers Vegan
    (14, 7), (14, 8), -- Customer 14 prefers Low-Carb and Paleo
    (15, 1),         -- Customer 15 prefers Vegetarian
    (16, 4),         -- Customer 16 prefers Nut-Free
    (17, 5),         -- Customer 17 prefers Dairy-Free
    (18, 9),         -- Customer 18 prefers Halal
    (19, 3),         -- Customer 19 prefers Gluten-Free
    (20, 6),         -- Customer 20 prefers Keto
    (21, 8),         -- Customer 21 prefers Paleo
    (22, 2), (22, 4), -- Customer 22 prefers Vegan and Nut-Free
    (23, 5), (23, 7), -- Customer 23 prefers Dairy-Free and Low-Carb
    (24, 6),         -- Customer 24 prefers Keto
    (25, 9),         -- Customer 25 prefers Halal
    (26, 1),         -- Customer 26 prefers Vegetarian
    (27, 3), (27, 5), -- Customer 27 prefers Gluten-Free and Dairy-Free
    (28, 7),         -- Customer 28 prefers Low-Carb
    (29, 8),         -- Customer 29 prefers Paleo
    (30, 2),         -- Customer 30 prefers Vegan
    (31, 6),         -- Customer 31 prefers Keto
    (32, 5),         -- Customer 32 prefers Dairy-Free
    (33, 4),         -- Customer 33 prefers Nut-Free
    (34, 7),         -- Customer 34 prefers Low-Carb
    (35, 1),         -- Customer 35 prefers Vegetarian
    (36, 8),         -- Customer 36 prefers Paleo
    (37, 9),         -- Customer 37 prefers Halal
    (38, 2),         -- Customer 38 prefers Vegan
    (39, 3),         -- Customer 39 prefers Gluten-Free
    (40, 6),         -- Customer 40 prefers Keto
    (41, 5),         -- Customer 41 prefers Dairy-Free
    (42, 4),         -- Customer 42 prefers Nut-Free
    (43, 7),         -- Customer 43 prefers Low-Carb
    (44, 1),         -- Customer 44 prefers Vegetarian
    (45, 3),         -- Customer 45 prefers Gluten-Free
    (46, 2),         -- Customer 46 prefers Vegan
    (47, 5),         -- Customer 47 prefers Dairy-Free
    (48, 9),         -- Customer 48 prefers Halal
    (49, 8),         -- Customer 49 prefers Paleo
    (50, 6);         -- Customer 50 prefers Keto
    

INSERT INTO Customer_OrderHistory (Customer_id, Order_id)
VALUES
    (1, 1),(1, 2),(2, 3),(2, 4),
    (3, 5),(3, 6),(4, 7),(5, 8),
    (6, 9),(7, 10),(8, 11),(9, 12),
    (10, 13),(11, 14),(12, 15),(13, 16),
    (14, 17),(15, 18),(16, 19),(17, 20),
    (18, 21),(19, 22),(20, 23),(21, 24),
    (22, 25),(23, 26),(24, 27),(25, 28),
    (26, 29),(27, 30),(28, 31),(29, 32),
    (30, 33),(31, 34),(32, 35),(33, 36),
    (34, 37),(35, 38),(36, 39),(37, 40),
    (38, 41),(39, 42),(40, 43),(41, 44),
    (42, 45),(43, 46),(44, 47),(45, 48),
    (46, 49),(47, 50);