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
