-- Zomato Data Analysis using SQL
CREATE TABLE customers(
		customer_id INT PRIMARY KEY,
		customer_name VARCHAR(25),
		reg_date DATE
		);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(35),
    loc VARCHAR(15),
    opening_hours VARCHAR(20)
);

CREATE TABLE riders (
    rider_id INT PRIMARY KEY,
    rider_name VARCHAR(35),
    mob_no VARCHAR(15),
    sign_up DATE
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id), --CUSTOMERS TABLE
    restaurant_id INT REFERENCES restaurants(restaurant_id), ---COMING FROM RESTAURANT TABLE
    order_item VARCHAR(55),
    order_date TIMESTAMP,
    order_status VARCHAR(50),
    total_amount NUMERIC(10,2)
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    delivery_status VARCHAR(30),
    delivery_time INT,
    rider_id INT REFERENCES riders(rider_id)
);

--- End of Schemas