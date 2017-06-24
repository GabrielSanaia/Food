CREATE TABLE food_user (

    id serial primary key,
    name VARCHAR(30),
    surname VARCHAR(30),
	username VARCHAR(30) UNIQUE,
    password VARCHAR(30),
    gender VARCHAR(30),
	imagePath TEXT
	
);