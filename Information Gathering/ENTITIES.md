
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
| artist |  Multivalued, not null | -  |
|  album |  Simple,	not null |  - |
|  song_url |  Simple,	not null |  - |
|  length |  Simple,	not null |  - |
|  number_of_times_played |  Simple,	not null |  - |


  # 3. Album
|  Attribute name  | type  | role  |
|---|:-:|---|
| album_id  |  Unique, not null  |  Primary Key |
| title  |  Simple, not null | -  |
| artist |  Multivalued, not null | -  |
|  release_date |  Simple,	not null |  - |
|  image_url |  Simple,	not null |  - |
|  album_length |  Simple,	not null |  - |
|  number_of_likes |  Simple,	not null |  - |


  # 4. LikedSong
|  Attribute name  | type  | role  |
|---|:-:|---|
| id  |  Unique, not null  |  Primary Key |
| username  |  Simple, not null | -  |
|  song_id |  Simple,	not null |  - |


  # 5. LikedAlbum
|  Attribute name  | type  | role  |
|---|:-:|---|
| id  |  Unique, not null  |  Primary Key |
| username  |  Simple, not null | -  |
|  album_id |  Simple,	not null |  - |


