--
-- PRACICE JOINS
--

-- (1)
SELECT * FROM invoice
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE unit_price >.99;

-- (2)
SELECT i.invoice_date, i.total, customer.first_name, customer.last_name FROM invoice as i
JOIN customer ON i.customer_id = customer.customer_id;

-- (3)
SELECT c.first_name, c.last_name, e.first_name, e.last_name FROM customer AS c
JOIN employee AS e ON c.support_rep_id = e.employee_id;

-- (4)
SELECT al.title, ar.name FROM artist AS ar
JOIN album AS al ON ar.artist_id = al.artist_id;

-- (5)
SELECT tr.track_id FROM playlist_track AS tr
JOIN playlist AS p ON tr.playlist_id = p.playlist_id
WHERE p.name = 'Music';

-- (6)
SELECT t.name FROM track AS t
JOIN playlist_track AS pt ON t.track_id = pt.track_id
JOIN playlist as p ON pt.playlist_id = p.playlist_id
WHERE p.playlist_id = 5;

-- (7)
SELECT t.name, p.name FROM track AS t
JOIN playlist_track AS pt ON t.track_id = pt.track_id
JOIN playlist as p ON pt.playlist_id = p.playlist_id

--(8)
SELECT t.name, a.title FROM track AS t
JOIN album AS a ON t.album_id = a.album_id
JOIN genre AS g ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative';

-- (Black Diamond)
SELECT t.name, g.name, al.title, ar.name FROM track AS t
JOIN album AS al ON t.album_id = al.album_id
JOIN genre AS g ON t.genre_id = g.genre_id
JOIN artist AS ar ON al.artist_id = ar.artist_id;

--
-- PRACTICE NESTED QUERIES
--

-- (1)
SELECT * FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line
                    WHERE unit_price > .99);

-- (2)
SELECT * FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist
                    WHERE name = 'Music');

-- (3)
SELECT name FROM track AS t
WHERE track_id IN (SELECT track_id FROM playlist
                WHERE playlist_id = 5);

-- (4)
SELECT * FROM track
WHERE genre_id IN (SELECT genre_id FROM genre
                WHERE name = 'Comedy');

-- (5)
SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album
                WHERE title = 'Fireball');

-- (6)
SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album
                WHERE artist_id IN
                    (SELECT artist_id FROM artist
                    WHERE name = 'Queen'));

--
-- PRACTICE UPDATING ROWS
--

-- (1)
UPDATE customer
SET fax = NULL;

-- (2)
UPDATE customer
SET company = 'Self'
WHERE company = NULL;

-- (3)
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND
last_name = 'Barnett';

-- (4)
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

-- (5)
UPDATE track
SET composer = 'The darkness around us'
WHERE composer = NULL
AND genre_id = (SELECT genre_id FROM genre
                WHERE name = 'Metal');

--
-- GROUP BY
--

-- (1)
SELECT g.name, count(*) FROM track as t
JOIN genre AS g ON t.genre_id = g.genre_id
GROUP BY g.name

-- (2)
SELECT g.name, count(*) FROM track as t
JOIN genre AS g ON t.genre_id = g.genre_id
WHERE g.name IN ('Pop', 'Rock')
GROUP BY g.name

-- (3)
SELECT ar.name, count(*) FROM artist as ar
JOIN album AS al ON ar.artist_id = al.album_id
GROUP BY ar.name

--
-- USE DISTINCT
--

-- (1)
SELECT DISTINCT composer
FROM track

-- (2)
SELECT DISTINCT billing_postal_code
FROM invoice

-- (3)
SELECT DISTINCT company
FROM customer

--
-- DELETE ROWS
--

-- (2)
DELETE FROM practice_delete
WHERE Type = 'bronze';

-- (3)
DELETE FROM practice_delete
WHERE Type = 'silver';

-- (4)
DELETE FROM practice_delete
WHERE Value = 150;

--
-- ECOMMERCE SIMULATION
--

CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR (150),
email VARCHAR (150)
);

CREATE TABLE product (
product_id SERIAL PRIMARY KEY,
name VARCHAR (150),
price INTEGER);

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
product_id INTEGER, 
FOREIGN KEY (product_id) REFERENCES product(product_id));

INSERT INTO users (name, email)
VALUES ('Laura', 'laura.jinks@gmail.com'),
('Person A', 'persona@gmail.com'),
('B Person', 'bperson@gmail.com');

INSERT INTO product (name, price)
VALUES ('Hat', 200), ('Cat', 4000), ('Bat', 100);

INSERT INTO orders (product_id)
VALUES (3), (1), (2)

SELECT name FROM product
WHERE product_id = (SELECT product_id FROM orders
                    WHERE order_id = 4);

SELECT * FROM orders

SELECT SUM(product.price) FROM orders
JOIN product ON orders.product_id = product.product_id
GROUP BY orders.order_id;

ALTER TABLE orders
ADD user_id INTEGER,
ADD FOREIGN KEY(user_id) REFERENCES users(user_id);

UPDATE orders
SET user_id = 7;

SELECT * FROM orders
WHERE user_id = (SELECT user_id FROM users
                WHERE name = 'Laura');

SELECT user_id, count(*) FROM orders
GROUP BY user_id;

SELECT user_id, SUM(product.price) FROM orders
JOIN product ON orders.product_id = product.product_id
GROUP BY user_id;
