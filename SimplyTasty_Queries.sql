USE SimplyTasty;

SELECT * FROM airshipment;
SELECT * FROM customer;
SELECT * FROM customer_dietarypreference;
SELECT * FROM customer_orderhistory;
SELECT * FROM dietaryoptions;
SELECT * FROM ingredient;
SELECT * FROM inventory;
SELECT * FROM landshipment;
SELECT * FROM mealkit;
SELECT * FROM mealkit_ingredients;
SELECT * FROM mealkit_orders;
SELECT * FROM orders;
SELECT * FROM recipe;
SELECT * FROM recipe_dietaryoptions;
SELECT * FROM recipe_ingredients;
SELECT s.Shipment_id, s.Shipment_status, s.Shipment_date, s.Shipment_address, c.Address AS destination_address FROM shipments s RIGHT JOIN customer c on s.Customer_id = c.Customer_id;