
drop database if exists food_delivery_db;

create database food_delivery_db;
use food_delivery_db;


-- CREATE TABLES --

CREATE TABLE driver (
    id INT PRIMARY KEY
		   AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);

CREATE TABLE customer (
    id INT PRIMARY KEY 
		   AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
					   UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE customer_address (
    id INT PRIMARY KEY 
		   AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code CHAR(5) NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customer (id)
);

CREATE TABLE credit_card (
    id INT PRIMARY KEY 
		   AUTO_INCREMENT,
    credit_card_number CHAR(16) NOT NULL,
    security_code CHAR(3) NOT NULL,
    expiration DATE NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customer (id)
);

CREATE TABLE restaurant_address (
    id INT PRIMARY KEY 
		   AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code CHAR(5) NOT NULL
);

CREATE TABLE restaurant (
    id INT PRIMARY KEY 
		   AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone CHAR(10) UNIQUE 
				   NOT NULL,
    address_id INT NOT NULL
				   UNIQUE,
    FOREIGN KEY (address_id)
        REFERENCES restaurant_address (id)
);

CREATE TABLE menu_items (
    id INT PRIMARY KEY 
		   AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(13 , 2 ) NOT NULL
						   CHECK( price >= 0 ),
    restaurant_id INT NOT NULL,
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurant (id)
);

CREATE TABLE customer_order (
    id INT PRIMARY KEY 
		   AUTO_INCREMENT,
    ordered DATETIME,
    restaurant_id INT NOT NULL,
    customer_id INT NOT NULL,
    driver_id INT NOT NULL,
    card_id INT NOT NULL,
    order_address_id INT NOT NULL,
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurant (id),
    FOREIGN KEY (customer_id)
        REFERENCES customer (id),
    FOREIGN KEY (driver_id)
        REFERENCES driver (id),
	FOREIGN KEY (card_id)
        REFERENCES credit_card (id),
    FOREIGN KEY (order_address_id)
        REFERENCES customer_address (id)
);

CREATE TABLE items_ordered (
    order_id INT,
    item_id INT,
    quantity TINYINT CHECK( quantity > 0),
    PRIMARY KEY (order_id , item_id),
    FOREIGN KEY (order_id)
        REFERENCES customer_order (id),
    FOREIGN KEY (item_id)
        REFERENCES menu_items (id)
);





-- CREATE DATA --

# DRIVER
insert into driver(id, first_name, last_name)
	values(1, 'Peppa', 'Pig');
insert into driver(id, first_name, last_name)
	values(2, 'Gumball', 'Waterson');

# CUSTOMER
insert into customer(id, first_name, last_name, email, password) 
	values(1, 'Sharpay', 'Evans', 'sharpay@gmail.com', 'shevans123');
insert into customer(id, first_name, last_name, email, password) 
	values(2, 'Rich', 'Bowers', 'bowers27@gmail.com', 'strongpassword@27');
insert into customer(id, first_name, last_name, email, password) 
	values(3, 'Darwin', 'Waterson', 'dwaterson@gmail.com', 'pw@567');

# CUSTOMER ADDRESS
insert into customer_address(id, street, city, state, zip_code, customer_id) 
	values(1, '2773 Wright Court', 'Dallas', 'TX', '75240', 1);
insert into customer_address(id, street, city, state, zip_code, customer_id) 
	values(2, '3825 Charla Lane', 'Dallas', 'TX', '75240', 1);
insert into customer_address(id, street, city, state, zip_code, customer_id) 
	values(3, '616 Orchard Street', 'Los Angeles', 'CA', '90017', 2);
insert into customer_address(id, street, city, state, zip_code, customer_id) 
	values(4, '603 Morris Street', 'Los Angeles', 'CA', '90017', 3);

# CREDIT CARD
insert into credit_card(id, credit_card_number, security_code, expiration, customer_id) 
	values(1, '1234567890123456', '123', DATE_ADD(current_date(), INTERVAL 2 YEAR), 1);
insert into credit_card(id, credit_card_number, security_code, expiration, customer_id) 
	values(2, '1234567890246802', '321', DATE_ADD(current_date(), INTERVAL 5 YEAR), 2);
insert into credit_card(id, credit_card_number, security_code, expiration, customer_id) 
	values(3, '1234567890369258', '010', DATE_ADD(current_date(), INTERVAL 9 MONTH), 2);
insert into credit_card(id, credit_card_number, security_code, expiration, customer_id) 
	values(4, '1234567890482604', '456', DATE_ADD(current_date(), INTERVAL 2 MONTH), 3);

# RESTAURANT ADDRESS
insert into restaurant_address(id, street, city, state, zip_code) 
	values(1, '4061 Copperhead Road', 'Dallas', 'TX', '75240');
insert into restaurant_address(id, street, city, state, zip_code) 
	values(2, '3427 Rivendell Drive', 'Dallas', 'TX', '75240');
insert into restaurant_address(id, street, city, state, zip_code) 
	values(3, '700 Glenwood Avenue', 'Dallas', 'TX', '75240');
insert into restaurant_address(id, street, city, state, zip_code) 
	values(4, '141 Quiet Valley Lane', 'Los Angeles', 'CA', '90017');
insert into restaurant_address(id, street, city, state, zip_code) 
	values(5, '2892 Barnes Street', 'Los Angeles', 'CA', '90017');
insert into restaurant_address(id, street, city, state, zip_code) 
	values(6, '2257 Lilac Lane', 'Los Angeles', 'CA', '90017');

# RESTAURANT
insert into restaurant(id, name, phone, address_id) 
	values(1, "Bobby's Pizza", '1234567890', 1);
insert into restaurant(id, name, phone, address_id) 
	values(2, "Easy Eats", '2468024680', 2);
insert into restaurant(id, name, phone, address_id) 
	values(3, "Panda Palace", '3692581470', 3);
insert into restaurant(id, name, phone, address_id) 
	values(4, "Pho My Way", '4826048260', 4);
insert into restaurant(id, name, phone, address_id) 
	values(5, "Taco House", '5050505050', 5);
insert into restaurant(id, name, phone, address_id) 
	values(6, "Soup & Salad Express", '6284062840', 6);

# MENU ITEMS
-- Bobby's Pizza
insert into menu_items(id, name, description, price, restaurant_id) 
	values(1, 'cheese pizza', '18 inch plain cheese pizza', 19.99, 1);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(2, 'pepperoni pizza', '18 inch cheese pizza with pepperoni', 21.99, 1);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(3, 'meat lovers pizza', '18 inch plain cheese pizza with sausages, pepperoni, meatballs, & more', 25.99, 1);
-- Easy Eats
insert into menu_items(id, name, description, price, restaurant_id) 
	values(4, 'turkey club', null, 3.99, 2);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(5, 'grilled cheese', null, 2.99, 2);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(6, 'mac & cheese', null, 3.49, 2);
-- Panda Palace
insert into menu_items(id, name, description, price, restaurant_id) 
	values(7, 'lo mein', null, 4.99, 3);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(8, 'pork fried rice', null, 3.95, 3);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(9, 'wonton soup', null, 2.00, 3);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(10, 'dumplings', null, 2.49, 3);
-- Pho My Way
insert into menu_items(id, name, description, price, restaurant_id) 
	values(11, 'pho', null, 9.99, 4);
-- Taco House
insert into menu_items(id, name, description, price, restaurant_id) 
	values(12, 'birria tacos', '5 birria tacos', 9.75, 5);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(13, 'carne asada tacos', '5 carne asada tacos', 9.75, 5);
-- Soup & Salad Express
insert into menu_items(id, name, description, price, restaurant_id) 
	values(14, 'chicken soup', null, 5.75, 6);
insert into menu_items(id, name, description, price, restaurant_id) 
	values(15, 'garden salad', null, 8.75, 6);

# CUSTOMER ORDER
insert into customer_order(id, ordered, restaurant_id, customer_id, driver_id, card_id, order_address_id) 
	values(1, now(), 1, 1, 1, 1, 1);
insert into customer_order(id, ordered, restaurant_id, customer_id, driver_id, card_id, order_address_id) 
	values(2, now(), 5, 3, 2, 4, 4);

# ITEMS ORDERED
insert into items_ordered(order_id, item_id, quantity) 
	values(1, 1, 3);
insert into items_ordered(order_id, item_id, quantity) 
	values(1, 2, 1);
insert into items_ordered(order_id, item_id, quantity) 
	values(2, 12, 1);

