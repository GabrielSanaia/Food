CREATE TABLE food(
	
	id SERIAL PRIMARY KEY,
	name VARCHAR(30),
	foodtype VARCHAR(10),
	cooking_way TEXT,
	ingredients TEXT,
	imagePath TEXT,
	user_id INT
);