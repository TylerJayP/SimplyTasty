USE SimplyTasty;

-- Customer table
CREATE TABLE IF NOT EXISTS Customer (
    Customer_id INT AUTO_INCREMENT PRIMARY KEY,
    First_name VARCHAR(80) NOT NULL,
    Last_name VARCHAR(80) NOT NULL,
    Address VARCHAR(50) DEFAULT NULL
);

-- Order History
CREATE TABLE IF NOT EXISTS Customer_OrderHistory (
    Customer_id INT,
    Order_id INT,
    
    PRIMARY KEY (Customer_id, Order_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE,
    FOREIGN KEY (Order_id) REFERENCES Orders(Order_id) ON DELETE CASCADE
);

-- Dietary Preference
CREATE TABLE IF NOT EXISTS Customer_DietaryPreference (
    Customer_id INT,
    Dietary_options_id INT,
    
    PRIMARY KEY (Customer_id, Dietary_options_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE,
    FOREIGN KEY (Dietary_options_id) REFERENCES Recipe_DietaryOptions(Dietary_options_id) ON DELETE CASCADE
);
