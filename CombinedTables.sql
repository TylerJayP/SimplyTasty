
DROP TABLE IF EXISTS Customer_DietaryPreference;
DROP TABLE IF EXISTS Customer_OrderHistory;
DROP TABLE IF EXISTS AirShipment;
DROP TABLE IF EXISTS LandShipment;
DROP TABLE IF EXISTS Recipe_DietaryOptions;
DROP TABLE IF EXISTS MealKit;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Shipments;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS Ingredient;


CREATE TABLE IF NOT EXISTS Recipe(
Recipe_id INT AUTO_INCREMENT PRIMARY KEY,
Recipe_name VARCHAR(60) NOT NULL,
Cuisine_type VARCHAR(60) DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS Ingredient (
    ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(60) NOT NULL
);
CREATE TABLE IF NOT EXISTS Customer (
    Customer_id INT AUTO_INCREMENT PRIMARY KEY,
    First_name VARCHAR(80) NOT NULL,
    Last_name VARCHAR(80) NOT NULL,
    Address VARCHAR(50) DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS Shipments(
Shipment_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
Shipment_status varchar(60),
Shipment_date DATE default NULL,
Shipment_address varchar(255),
Destination_address varchar(255),
Customer_id INT,
FOREIGN KEY(Customer_id) REFERENCES Customer(Customer_id)
);
CREATE TABLE IF NOT EXISTS LandShipment(
Vehicle_type varchar(50),
Delivery_shipper_name varchar(100),
Shipment_id int,
FOREIGN KEY (Shipment_id) REFERENCES Shipments(Shipment_id)
);
CREATE TABLE IF NOT EXISTS AirShipment(
Flight_num varchar(50),
Airline_name varchar(100),
Shipment_id int,
FOREIGN KEY (Shipment_id) REFERENCES Shipments(Shipment_id)
);
CREATE TABLE IF NOT EXISTS Orders(
Order_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
Order_price decimal(5,2) NOT NULL,
Order_date DATE DEFAULT NULL,
Shipment_id INT,
Customer_id INT,
FOREIGN KEY (Shipment_id) REFERENCES Shipments(Shipment_id),
FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);
CREATE TABLE IF NOT EXISTS Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    ingredient_id INT,
    quantity INT NOT NULL,
    restock_date DATE,
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
);
CREATE TABLE IF NOT EXISTS MealKit(
Mealkit_id INT AUTO_INCREMENT PRIMARY KEY,
Recipe_id INT,
Customization_options INT DEFAULT NULL, 

FOREIGN KEY (Recipe_id) REFERENCES Recipe (Recipe_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Recipe_DietaryOptions(
Dietary_options_id INT AUTO_INCREMENT PRIMARY KEY,
Recipe_id INT,

FOREIGN KEY (Recipe_id) REFERENCES Recipe(Recipe_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Customer_OrderHistory (
    Customer_id INT,
    Order_id INT,
    
    PRIMARY KEY (Customer_id, Order_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE,
    FOREIGN KEY (Order_id) REFERENCES Orders(Order_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Customer_DietaryPreference (
    Customer_id INT,
    Dietary_options_id INT,
    
    PRIMARY KEY (Customer_id, Dietary_options_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE,
    FOREIGN KEY (Dietary_options_id) REFERENCES Recipe_DietaryOptions(Dietary_options_id) ON DELETE CASCADE
);

##Probably should INSERT IN SAME ORDER AS CREATING TABLES
# Needs Customer Table before I can Insert DATE
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

INSERT INTO Orders (Order_price, Order_date, Shipment_id, Customer_id) VALUES
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

INSERT INTO AirShipment (Flight_num, Airline_name, Shipment_id) VALUES
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

INSERT INTO LandShipment (Vehicle_type, Delivery_shipper_name, Shipment_id) VALUES
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

INSERT INTO Ingredient (item_name) VALUES 
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

INSERT INTO Inventory (ingredient_id, quantity, restock_date) VALUES 
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