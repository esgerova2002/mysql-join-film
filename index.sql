
CREATE DATABASE movie_db;


USE movie_db;


CREATE TABLE users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO users(username, email, password)
VALUES 
('user1', 'user1@gmail.com', '1qwsed232w'),
('user2', 'user2@gmail.com', '2wedfewdwef'),
('user3', 'user3@gmail.com', '21345tgerd');


CREATE TABLE categories(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO categories(name)
VALUES 
('Action'),
('Drama'),
('Comedy');


CREATE TABLE films (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    release_date DATE,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);


INSERT INTO films (title, description, release_date, category_id)
VALUES 
('Tarot', 'Description for Tarot', '2000-03-05', 1),
('The Idea of You', 'Description for The Idea of You', '2020-02-10', 2),
('The Gangster, the Cop, the Devil', 'Description for The Gangster, the Cop, the Devil', '2024-03-01', 3);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT,
    user_id INT,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO comments (film_id, user_id, comment)
VALUES 
(1, 1, 'Cox yaxi film!'),
(2, 2, 'Maraqlarima uygun fim deyil.'),
(3, 3, 'Filmde aksiyon var idi.');


CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO wishlist (film_id, user_id)
VALUES 
(1, 1),
(2, 2),
(3, 3);
-- Butun Filmleri kateqoriya adlari ile gosterin.
SELECT f.title, f.description, f.release_date, c.name AS category_name
FROM films f
JOIN categories c ON f.category_id = c.id;
-- Spesifik filmin butun kommentlerini getirin
SELECT u.username, c.comment, c.created_at
FROM comments c
JOIN users u ON c.user_id = u.id
WHERE c.film_id = 1;

-- Userin wishlistindeki butun filmleri detalli melumatlari ile birge getiurin(filmin adi, release date ve s.)
SELECT f.title, f.description, f.release_date, c.name AS category_name
FROM wishlist w
JOIN films f ON w.film_id = f.id
JOIN categories c ON f.category_id = c.id
WHERE w.user_id = 1;

-- Butun commentleri commenti yazan sexsin adi ile birge getirin
SELECT u.username, c.comment, c.created_at
FROM comments c
JOIN users u ON c.user_id = u.id;
-- Butun filmleri commentlerinin sayi ile birge getirin
SELECT f.title, COUNT(c.id) AS comment_count
FROM films f
LEFT JOIN comments c ON f.id = c.film_id
GROUP BY f.id;
