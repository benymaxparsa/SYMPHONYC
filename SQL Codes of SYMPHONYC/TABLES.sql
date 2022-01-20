
-- Parsa KamaliPour 97149081

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

CREATE TABLE LikedAlbums(
	username CHARACTER VARYING,
	album_id CHARACTER VARYING,
	user_given_score DOUBLE PRECISION,
	CONSTRAINT LikedAlbums_PK PRIMARY KEY (album_id, username),
	CONSTRAINT LikedAlbums_FK1 FOREIGN KEY (username) REFERENCES NormalUsers (username),
	CONSTRAINT LikedAlbums_FK2 FOREIGN KEY (album_id) REFERENCES Albums (album_id),
	CONSTRAINT user_given_score_limit CHECK (user_given_score BETWEEN 0.0 AND 5.0)
);

CREATE TABLE Follows(
	follower_username CHARACTER VARYING,
	following_username CHARACTER VARYING,
	date_of_following DATE,
	CONSTRAINT Follows_PK PRIMARY KEY (follower_username, following_username),
	CONSTRAINT Follows_FK1 FOREIGN KEY (following_username) REFERENCES NormalUsers (username),
	CONSTRAINT Follows_FK2 FOREIGN KEY (follower_username) REFERENCES NormalUsers (username)
);

CREATE TABLE FavoriteArtists(
	person_username CHARACTER VARYING,
	artist_username CHARACTER VARYING,
	date_of_following DATE,
	CONSTRAINT FavoriteArtists_PK PRIMARY KEY (person_username, artist_username),
	CONSTRAINT FavoriteArtists_FK1 FOREIGN KEY (person_username) REFERENCES NormalUsers (username),
	CONSTRAINT FavoriteArtists_FK2 FOREIGN KEY (artist_username) REFERENCES Artists (username)
);

CREATE TABLE Playlists(
	playlist_id CHARACTER VARYING,
	creator_username CHARACTER VARYING,
	title CHARACTER VARYING,
	number_of_followers INTEGER,
	description CHARACTER VARYING,
	image_url CHARACTER VARYING,
	CONSTRAINT Playlists_PK PRIMARY KEY (playlist_id),
	CONSTRAINT Playlists_FK FOREIGN KEY (creator_username) REFERENCES NormalUsers (username)
);

CREATE TABLE FollowedPlaylists(
	username CHARACTER VARYING,
	playlist_id CHARACTER VARYING,
	user_given_score DOUBLE PRECISION,
	CONSTRAINT FollowedPlaylists_PK PRIMARY KEY (playlist_id, username),
	CONSTRAINT FollowedPlaylists_FK1 FOREIGN KEY (username) REFERENCES NormalUsers (username),
	CONSTRAINT FollowedPlaylists_FK2 FOREIGN KEY (playlist_id) REFERENCES Playlists (playlist_id),
	CONSTRAINT user_given_score_limit CHECK (user_given_score BETWEEN 0.0 AND 5.0)
);

CREATE TABLE Songs(
	song_id CHARACTER VARYING,
	album_id CHARACTER VARYING,
	title CHARACTER VARYING,
	song_length TIME,
	song_url CHARACTER VARYING,
	number_of_times_played INTEGER,
	CONSTRAINT Songs_PK PRIMARY KEY (song_id),
	CONSTRAINT Songs_FK FOREIGN KEY (album_id) REFERENCES Albums (album_id)
);

CREATE TABLE LikedSongs(
	username CHARACTER VARYING,
	song_id CHARACTER VARYING,
	user_given_score DOUBLE PRECISION,
	CONSTRAINT LikedSongs_PK PRIMARY KEY (song_id, username),
	CONSTRAINT LikedSongs_FK1 FOREIGN KEY (username) REFERENCES NormalUsers (username),
	CONSTRAINT LikedSongs_FK2 FOREIGN KEY (song_id) REFERENCES Songs (song_id),
	CONSTRAINT user_given_score_limit CHECK (user_given_score BETWEEN 0.0 AND 5.0)
);

CREATE TABLE PlaylistSongs(
	playlist_id CHARACTER VARYING,
	song_id CHARACTER VARYING,
	CONSTRAINT PlaylistSongs_PK PRIMARY KEY (song_id, playlist_id),
	CONSTRAINT PlaylistSongs_FK1 FOREIGN KEY (playlist_id) REFERENCES Playlists (playlist_id),
	CONSTRAINT PlaylistSongs_FK2 FOREIGN KEY (song_id) REFERENCES Songs (song_id)
);

CREATE TABLE SongArtists(
	artist_username CHARACTER VARYING,
	song_id CHARACTER VARYING,
	CONSTRAINT SongArtists_PK PRIMARY KEY (song_id, artist_username),
	CONSTRAINT SongArtists_FK1 FOREIGN KEY (artist_username) REFERENCES Artists (username),
	CONSTRAINT SongArtists_FK2 FOREIGN KEY (song_id) REFERENCES Songs (song_id)
);

