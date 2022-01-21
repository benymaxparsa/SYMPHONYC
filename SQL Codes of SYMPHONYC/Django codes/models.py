from django.db import models


class Album(models.Model):
    album_id = models.CharField(primary_key=True, max_length=100)
    title = models.CharField(max_length=100, blank=True, null=True)
    artist_username = models.ForeignKey('Artist', models.DO_NOTHING, db_column='artist_username', blank=True, null=True)
    album_length = models.TimeField(blank=True, null=True)
    number_of_likes = models.IntegerField(blank=True, null=True)
    image_url = models.CharField(max_length=100, blank=True, null=True)
    release_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'album'


class Artist(models.Model):
    username = models.OneToOneField('User', models.DO_NOTHING, db_column='username', primary_key=True)
    monthly_listeners = models.IntegerField(blank=True, null=True)
    rank = models.IntegerField(unique=True, blank=True, null=True)
    social_media_url = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'artist'



class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class FavoriteArtist(models.Model):
    person_username = models.OneToOneField('NormalUser', models.DO_NOTHING, db_column='person_username', primary_key=True)
    artist_username = models.ForeignKey(Artist, models.DO_NOTHING, db_column='artist_username')
    date_of_following = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'favorite_artist'
        unique_together = (('person_username', 'artist_username'),)


class FollowedPlaylist(models.Model):
    username = models.ForeignKey('NormalUser', models.DO_NOTHING, db_column='username')
    playlist = models.OneToOneField('Playlist', models.DO_NOTHING, primary_key=True)
    user_given_score = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'followed_playlist'
        unique_together = (('playlist', 'username'),)


class FollowingList(models.Model):
    follower = models.OneToOneField('NormalUser', models.DO_NOTHING, db_column='follower', primary_key=True)
    target = models.ForeignKey('NormalUser', models.DO_NOTHING, db_column='target', related_name='+')
    date_of_following = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'following_list'
        unique_together = (('follower', 'target'),)


class LikedAlbum(models.Model):
    username = models.ForeignKey('NormalUser', models.DO_NOTHING, db_column='username')
    album = models.OneToOneField(Album, models.DO_NOTHING, primary_key=True)
    user_given_score = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'liked_album'
        unique_together = (('album', 'username'),)


class LikedSong(models.Model):
    username = models.ForeignKey('NormalUser', models.DO_NOTHING, db_column='username')
    song = models.OneToOneField('Song', models.DO_NOTHING, primary_key=True)
    user_given_score = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'liked_song'
        unique_together = (('song', 'username'),)


class NormalUser(models.Model):
    username = models.OneToOneField('User', models.DO_NOTHING, db_column='username', primary_key=True)
    last_played_song = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'normal_user'


class Playlist(models.Model):
    playlist_id = models.CharField(primary_key=True, max_length=100)
    creator_username = models.ForeignKey(NormalUser, models.DO_NOTHING, db_column='creator_username', blank=True, null=True)
    title = models.CharField(max_length=100, blank=True, null=True)
    number_of_followers = models.IntegerField(blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    image_url = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'playlist'


class PlaylistSong(models.Model):
    playlist = models.ForeignKey(Playlist, models.DO_NOTHING)
    song = models.OneToOneField('Song', models.DO_NOTHING, primary_key=True)

    class Meta:
        managed = False
        db_table = 'playlist_song'
        unique_together = (('song', 'playlist'),)


class Song(models.Model):
    song_id = models.CharField(primary_key=True, max_length=100)
    album = models.ForeignKey(Album, models.DO_NOTHING, blank=True, null=True)
    title = models.CharField(max_length=100, blank=True, null=True)
    song_length = models.TimeField(blank=True, null=True)
    song_url = models.CharField(max_length=100, blank=True, null=True)
    number_of_times_played = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'song'


class SongFeatureArtist(models.Model):
    artist_username = models.ForeignKey(Artist, models.DO_NOTHING, db_column='artist_username')
    song = models.OneToOneField(Song, models.DO_NOTHING, primary_key=True)

    class Meta:
        managed = False
        db_table = 'song_feature_artist'
        unique_together = (('song', 'artist_username'),)


class User(models.Model):
    username = models.CharField(primary_key=True, max_length=100)
    name = models.CharField(max_length=100, blank=True, null=True)
    image_url = models.CharField(max_length=100, blank=True, null=True)
    password = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'user'
