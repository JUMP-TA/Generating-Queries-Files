CREATE TABLE driver (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE customer (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);

CREATE TABLE customer_address (
    id INTEGER PRIMARY KEY,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code TEXT NOT NULL,
    customer_id INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (id)
);

CREATE TABLE credit_card (
    id INTEGER PRIMARY KEY,
    credit_card_number TEXT NOT NULL,
    security_code TEXT NOT NULL,
    expiration TEXT NOT NULL,
    customer_id INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (id)
);

CREATE TABLE restaurant_address (
    id INTEGER PRIMARY KEY,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code TEXT NOT NULL
);

CREATE TABLE restaurant (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    phone TEXT NOT NULL UNIQUE,
    address_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (address_id) REFERENCES restaurant_address (id)
);

CREATE TABLE menu_items (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL CHECK(price >= 0),
    restaurant_id INTEGER NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant (id)
);

CREATE TABLE customer_order (
    id INTEGER PRIMARY KEY,
    ordered TEXT,
    restaurant_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    driver_id INTEGER NOT NULL,
    card_id INTEGER NOT NULL,
    order_address_id INTEGER NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant (id),
    FOREIGN KEY (customer_id) REFERENCES customer (id),
    FOREIGN KEY (driver_id) REFERENCES driver (id),
    FOREIGN KEY (card_id) REFERENCES credit_card (id),
    FOREIGN KEY (order_address_id) REFERENCES customer_address (id)
);

CREATE TABLE items_ordered (
    order_id INTEGER,
    item_id INTEGER,
    quantity INTEGER CHECK(quantity > 0),
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES customer_order (id),
    FOREIGN KEY (item_id) REFERENCES menu_items (id)
);


INSERT INTO driver(id, first_name, last_name)
VALUES(1, 'Peppa', 'Pig');
INSERT INTO driver(id, first_name, last_name)
VALUES(2, 'Gumball', 'Waterson');


INSERT INTO customer(id, first_name, last_name, email, password) 
VALUES(1, 'Sharpay', 'Evans', 'sharpay@gmail.com', 'shevans123');
INSERT INTO customer(id, first_name, last_name, email, password) 
VALUES(2, 'Rich', 'Bowers', 'bowers27@gmail.com', 'strongpassword@27');
INSERT INTO customer(id, first_name, last_name, email, password) 
VALUES(3, 'Darwin', 'Waterson', 'dwaterson@gmail.com', 'pw@567');


INSERT INTO customer_address(id, street, city, state, zip_code, customer_id) 
VALUES(1, '2773 Wright Court', 'Dallas', 'TX', '75240', 1);
INSERT INTO customer_address(id, street, city, state, zip_code, customer_id) 
VALUES(2, '3825 Charla Lane', 'Dallas', 'TX', '75240', 1);
INSERT INTO customer_address(id, street, city, state, zip_code, customer_id) 
VALUES(3, '616 Orchard Street', 'Los Angeles', 'CA', '90017', 2);
INSERT INTO customer_address(id, street, city, state, zip_code, customer_id) 
VALUES(4, '603 Morris Street', 'Los Angeles', 'CA', '90017', 3);


INSERT INTO credit_card(id, credit_card_number, security_code, expiration, customer_id) 
VALUES(1, '1234567890123456', '123', '2026-02-04', 1);
INSERT INTO credit_card(id, credit_card_number, security_code, expiration, customer_id) 
VALUES(2, '1234567890246802', '321', '2029-02-04', 2);
INSERT INTO credit_card(id, credit_card_number, security_code, expiration, customer_id) 
VALUES(3, '1234567890369258', '010', '2025-11-04', 2);
INSERT INTO credit_card(id, credit_card_number, security_code, expiration, customer_id) 
VALUES(4, '1234567890482604', '456', '2025-04-04', 3);


INSERT INTO restaurant_address(id, street, city, state, zip_code) 
VALUES(1, '4061 Copperhead Road', 'Dallas', 'TX', '75240');
INSERT INTO restaurant_address(id, street, city, state, zip_code) 
VALUES(2, '3427 Rivendell Drive', 'Dallas', 'TX', '75240');
INSERT INTO restaurant_address(id, street, city, state, zip_code) 
VALUES(3, '700 Glenwood Avenue', 'Dallas', 'TX', '75240');
INSERT INTO restaurant_address(id, street, city, state, zip_code) 
VALUES(4, '141 Quiet Valley Lane', 'Los Angeles', 'CA', '90017');
INSERT INTO restaurant_address(id, street, city, state, zip_code) 
VALUES(5, '2892 Barnes Street', 'Los Angeles', 'CA', '90017');
INSERT INTO restaurant_address(id, street, city, state, zip_code) 
VALUES(6, '2257 Lilac Lane', 'Los Angeles', 'CA', '90017');


INSERT INTO restaurant(id, name, phone, address_id) 
VALUES(1, "Bobby's Pizza", '1234567890', 1);
INSERT INTO restaurant(id, name, phone, address_id) 
VALUES(2, 'Easy Eats', '2468024680', 2);
INSERT INTO restaurant(id, name, phone, address_id) 
VALUES(3, 'Panda Palace', '3692581470', 3);
INSERT INTO restaurant(id, name, phone, address_id) 
VALUES(4, 'Pho My Way', '4826048260', 4);
INSERT INTO restaurant(id, name, phone, address_id) 
VALUES(5, 'Taco House', '5050505050', 5);
INSERT INTO restaurant(id, name, phone, address_id) 
VALUES(6, 'Soup & Salad Express', '6284062840', 6);


INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(1, 'cheese pizza', '18 inch plain cheese pizza', 19.99, 1);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(2, 'pepperoni pizza', '18 inch cheese pizza with pepperoni', 21.99, 1);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(3, 'meat lovers pizza', '18 inch plain cheese pizza with sausages, pepperoni, meatballs, & more', 25.99, 1);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(4, 'turkey club', NULL, 3.99, 2);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(5, 'grilled cheese', NULL, 2.99, 2);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(6, 'mac & cheese', NULL, 3.49, 2);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(7, 'lo mein', NULL, 4.99, 3);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(8, 'pork fried rice', NULL, 3.95, 3);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(9, 'wonton soup', NULL, 2.00, 3);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(10, 'dumplings', NULL, 2.49, 3);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(11, 'pho', NULL, 9.99, 4);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(12, 'birria tacos', '5 birria tacos', 9.75, 5);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(13, 'carne asada tacos', '5 carne asada tacos', 9.75, 5);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(14, 'chicken soup', NULL, 5.75, 6);
INSERT INTO menu_items(id, name, description, price, restaurant_id) 
VALUES(15, 'garden salad', NULL, 8.75, 6);


INSERT INTO customer_order(id, ordered, restaurant_id, customer_id, driver_id, card_id, order_address_id) 
VALUES(1, CURRENT_TIMESTAMP, 1, 1, 1, 1, 1);
INSERT INTO customer_order(id, ordered, restaurant_id, customer_id, driver_id, card_id, order_address_id) 
VALUES(2, CURRENT_TIMESTAMP, 5, 3, 2, 4, 4);


INSERT INTO items_ordered(order_id, item_id, quantity) 
VALUES(1, 1, 3);
INSERT INTO items_ordered(order_id, item_id, quantity) 
VALUES(1, 2, 1);
INSERT INTO items_ordered(order_id, item_id, quantity) 
VALUES(2, 12, 1);