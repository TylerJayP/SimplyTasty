USE SimplyTasty;

CREATE TABLE IF NOT EXISTS Orders(
Order_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
Order_price decimal(5,2) NOT NULL,
Order_date DATE DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS Shipments(
Shipment_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
Shipment_status varchar(60),
Shipment_date DATE default NULL,
Shipment_address varchar(255),
Destination_address varchar(255)
);

CREATE TABLE IF NOT EXISTS LandShipment(
Vehicle_type varchar(50),
Delivery_shipper_name varchar(100),
Shipment_id int
-- FOREIGN KEY Shipment_id REFERENCES Shipments(Shipment_id)
);

CREATE TABLE IF NOT EXISTS AirShipment(
Flight_num varchar(50),
Airline_name varchar(100),
Shipment_id int
-- FOREIGN KEY Shipment_id REFERENCES Shipments(Shipment_id)
);