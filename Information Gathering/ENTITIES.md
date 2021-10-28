
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