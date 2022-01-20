
SET search_path TO "SYMPHONYC";

CREATE TABLE Users(
	username CHARACTER VARYING UNIQUE,
	name CHARACTER VARYING,
	image_url CHARACTER VARYING,
	password CHARACTER VARYING,
	CONSTRAINT Users_PK PRIMARY KEY (username)
);


CREATE TABLE Artists(
	username CHARACTER VARYING UNIQUE,
	monthly_listeners INTEGER,
	rank INTEGER UNIQUE,
	social_media_url CHARACTER VARYING,
	CONSTRAINT Artists_PK PRIMARY KEY (username),
	CONSTRAINT Artists_FK FOREIGN KEY (username) REFERENCES Users (username)
);

CREATE TABLE NormalUsers(
	username CHARACTER VARYING UNIQUE,
	last_played_song CHARACTER VARYING,
	CONSTRAINT NormalUsers_PK PRIMARY KEY (username),
	CONSTRAINT NormalUsers_FK FOREIGN KEY (username) REFERENCES Users (username)
);

CREATE TABLE Albums(
	album_id CHARACTER VARYING,
	title CHARACTER VARYING,
	artist_username CHARACTER VARYING,
	album_length TIME,
	number_of_likes INTEGER,
	image_url CHARACTER VARYING,
	release_date DATE,
	CONSTRAINT Albums_PK PRIMARY KEY (album_id),
	CONSTRAINT Albums_FK FOREIGN KEY (artist_username) REFERENCES Artists (username)
);



