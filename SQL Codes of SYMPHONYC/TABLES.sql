
-- Parsa KamaliPour 97149081

SET search_path TO "SYMPHONYC";

CREATE TABLE User(
	username CHARACTER VARYING(100) UNIQUE,
	name CHARACTER VARYING(100),
	image_url CHARACTER VARYING(100),
	password CHARACTER VARYING(100),
	CONSTRAINT User_PK PRIMARY KEY (username)
);


CREATE TABLE Artist(
	username CHARACTER VARYING(100) UNIQUE,
	monthly_listeners INTEGER,
	rank INTEGER UNIQUE,
	social_media_url CHARACTER VARYING(100),
	CONSTRAINT Artist_PK PRIMARY KEY (username),
	CONSTRAINT Artist_FK FOREIGN KEY (username) REFERENCES User (username)
);

CREATE TABLE Normal_User(
	username CHARACTER VARYING(100) UNIQUE,
	last_played_song CHARACTER VARYING(100),
	CONSTRAINT Normal_User_PK PRIMARY KEY (username),
	CONSTRAINT Normal_User_FK FOREIGN KEY (username) REFERENCES User (username)
);

CREATE TABLE Album(
	album_id CHARACTER VARYING(100),
	title CHARACTER VARYING(100),
	artist_username CHARACTER VARYING(100),
	album_length TIME,
	number_of_likes INTEGER,
	image_url CHARACTER VARYING(100),
	release_date DATE,
	CONSTRAINT Album_PK PRIMARY KEY (album_id),
	CONSTRAINT Album_FK FOREIGN KEY (artist_username) REFERENCES Artist (username)
);

CREATE TABLE Liked_Album(
	username CHARACTER VARYING(100),
	album_id CHARACTER VARYING(100),
	user_given_score DOUBLE PRECISION,
	CONSTRAINT Liked_Album_PK PRIMARY KEY (album_id, username),
	CONSTRAINT Liked_Album_FK1 FOREIGN KEY (username) REFERENCES Normal_User (username),
	CONSTRAINT Liked_Album_FK2 FOREIGN KEY (album_id) REFERENCES Album (album_id),
	CONSTRAINT user_given_score_limit CHECK (user_given_score BETWEEN 0.0 AND 5.0)
);

CREATE TABLE following_list(
	follower CHARACTER VARYING(100),
	target CHARACTER VARYING(100),
	date_of_following DATE,
	CONSTRAINT following_list_PK PRIMARY KEY (follower, target),
	CONSTRAINT following_list_FK1 FOREIGN KEY (follower) REFERENCES Normal_User (username),
	CONSTRAINT following_list_FK2 FOREIGN KEY (target) REFERENCES Normal_User (username)
);

CREATE TABLE Favorite_Artist(
	person_username CHARACTER VARYING(100),
	artist_username CHARACTER VARYING(100),
	date_of_following DATE,
	CONSTRAINT Favorite_Artist_PK PRIMARY KEY (person_username, artist_username),
	CONSTRAINT Favorite_Artist_FK1 FOREIGN KEY (person_username) REFERENCES Normal_User (username),
	CONSTRAINT Favorite_Artist_FK2 FOREIGN KEY (artist_username) REFERENCES Artist (username)
);

CREATE TABLE Playlist(
	playlist_id CHARACTER VARYING(100),
	creator_username CHARACTER VARYING(100),
	title CHARACTER VARYING(100),
	number_of_followers INTEGER,
	description CHARACTER VARYING(200),
	image_url CHARACTER VARYING(100),
	CONSTRAINT Playlist_PK PRIMARY KEY (playlist_id),
	CONSTRAINT Playlist_FK FOREIGN KEY (creator_username) REFERENCES Normal_User (username)
);

CREATE TABLE Followed_Playlist(
	username CHARACTER VARYING(100),
	playlist_id CHARACTER VARYING(100),
	user_given_score DOUBLE PRECISION,
	CONSTRAINT Followed_Playlist_PK PRIMARY KEY (playlist_id, username),
	CONSTRAINT Followed_Playlist_FK1 FOREIGN KEY (username) REFERENCES Normal_User (username),
	CONSTRAINT Followed_Playlist_FK2 FOREIGN KEY (playlist_id) REFERENCES Playlist (playlist_id),
	CONSTRAINT user_given_score_limit CHECK (user_given_score BETWEEN 0.0 AND 5.0)
);

CREATE TABLE Song(
	song_id CHARACTER VARYING(100),
	album_id CHARACTER VARYING(100),
	title CHARACTER VARYING(100),
	song_length TIME,
	song_url CHARACTER VARYING(100),
	number_of_times_played INTEGER,
	CONSTRAINT Song_PK PRIMARY KEY (song_id),
	CONSTRAINT Song_FK FOREIGN KEY (album_id) REFERENCES Album (album_id)
);

CREATE TABLE Liked_Song(
	username CHARACTER VARYING(100),
	song_id CHARACTER VARYING(100),
	user_given_score DOUBLE PRECISION,
	CONSTRAINT Liked_Song_PK PRIMARY KEY (song_id, username),
	CONSTRAINT Liked_Song_FK1 FOREIGN KEY (username) REFERENCES Normal_User (username),
	CONSTRAINT Liked_Song_FK2 FOREIGN KEY (song_id) REFERENCES Song (song_id),
	CONSTRAINT user_given_score_limit CHECK (user_given_score BETWEEN 0.0 AND 5.0)
);

CREATE TABLE Playlist_Song(
	playlist_id CHARACTER VARYING(100),
	song_id CHARACTER VARYING(100),
	CONSTRAINT Playlist_Song_PK PRIMARY KEY (song_id, playlist_id),
	CONSTRAINT Playlist_Song_FK1 FOREIGN KEY (playlist_id) REFERENCES Playlist (playlist_id),
	CONSTRAINT Playlist_Song_FK2 FOREIGN KEY (song_id) REFERENCES Song (song_id)
);

CREATE TABLE song_feature_artist(
	artist_username CHARACTER VARYING(100),
	song_id CHARACTER VARYING(100),
	CONSTRAINT song_feature_artist_PK PRIMARY KEY (song_id, artist_username),
	CONSTRAINT song_feature_artist_FK1 FOREIGN KEY (artist_username) REFERENCES Artist (username),
	CONSTRAINT song_feature_artist_FK2 FOREIGN KEY (song_id) REFERENCES Song (song_id)
);

