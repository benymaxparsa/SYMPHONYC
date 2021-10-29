
<br />
<p align="center">
  
  <h1 align="center">SYMPHONYC</h1>

  <p align="center">
    The database of a music streaming service similar to Spotify.
    <br />
    Information gathering:
    <br />
    Entities & their Attributes.
  <br />
  

  # 1. User
|  Attribute name  | type  | role  |
|---|:-:|---|
| Username  |  Unique, not null  |  Primary Key |
| Name  |  Simple, not null | -  |
| last_played_song  |  Simple, nullable | -  |
|  Image_url |  Simple,	not null |  - |
|  Password |  Simple,	not null |  - |

  # 2. Song
|  Attribute name  | type  | role  |
|---|:-:|---|
| song_id  |  Unique, not null  |  Primary Key |
| title  |  Simple, not null | -  |
| artist |  Unique, Multivalued, not null | -  |
|  album |  Unique,	not null |  - |
|  song_url |  Simple,	not null |  - |
|  length |  Simple,	not null |  - |
|  number_of_times_played |  Simple,	not null |  - |


  # 3. Album
|  Attribute name  | type  | role  |
|---|:-:|---|
| album_id  |  Unique, not null  |  Primary Key |
| title  |  Simple, not null | -  |
| artist |  Unique, Multivalued, not null | -  |
|  release_date |  Simple,	not null |  - |
|  image_url |  Simple,	not null |  - |
|  album_length |  Simple,	not null |  - |
|  number_of_likes |  Simple,	not null |  - |


  # 4. LikedSong
|  Attribute name  | type  | role  |
|---|:-:|---|
| id  |  Unique, not null  |  Primary Key |
| username  |  Unique, not null | -  |
|  song_id |  Unique,	not null |  - |


  # 5. LikedAlbum
|  Attribute name  | type  | role  |
|---|:-:|---|
| id  |  Unique, not null  |  Primary Key |
| username  |  Unique, not null | -  |
|  album_id |  Unique,	not null |  - |


  # 6. FavoriteArtist
|  Attribute name  | type  | role  |
|---|:-:|---|
| id  |  Unique, not null  |  Primary Key |
| username  |  Unique, not null | -  |
|  artist_username |  Unique,	not null |  - |


  # 7. Artist
|  Attribute name  | type  | role  |
|---|:-:|---|
| username  |  Unique, not null  |  Primary Key |
| name  |  Simple, not null | -  |
| social_media_url |  Multivalued, nullable | -  |
|  number_of_monthly_listeners |  Simple,	not null |  - |
|  image_url |  Simple,	not null |  - |
|  rank |  Simple,	not null |  - |


  # 8. Playlist
|  Attribute name  | type  | role  |
|---|:-:|---|
| playlist_id  |  Unique, not null  |  Primary Key |
| title  |  Simple, not null | -  |
| creator_username |  Unique, not null | -  |
|  description |  Simple,	nullable |  - |
|  image_url |  Simple,	not null |  - |
|  number_of_followers |  Simple,	not null |  - |


  # 9. PlaylistSong
|  Attribute name  | type  | role  |
|---|:-:|---|
| id  |  Unique, not null  |  Primary Key |
| playlist_id  |  Unique, not null | -  |
|  song_id |  Unique,	not null |  - |


  # 10. FollowedPlaylist
|  Attribute name  | type  | role  |
|---|:-:|---|
| id  |  Unique, not null  |  Primary Key |
| follower_username  |  Unique, not null | -  |
|  playlist_id |  Unique,	not null |  - |


  # 11. FollowedUsers
|  Attribute name  | type  | role  |
|---|:-:|---|
| id  |  Unique, not null  |  Primary Key |
| follower_username  |  Unique, not null | -  |
|  following_username |  Unique,	not null |  - |