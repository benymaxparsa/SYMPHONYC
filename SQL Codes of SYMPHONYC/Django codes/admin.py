from django.contrib import admin
from .models import Album, Artist, FavoriteArtist, FollowedPlaylist, FollowingList, LikedAlbum, \
    LikedSong, NormalUser, Playlist, PlaylistSong, SongFeatureArtist, Song, User
from django.db import connection

class ArtistInline(admin.TabularInline):
    model = Artist

class NormalUserInline(admin.TabularInline):
    model = NormalUser

class FavoriteArtistInline(admin.TabularInline):
    model = FavoriteArtist

class AlbumInline(admin.TabularInline):
    model = Album

class SongFeatureArtistInline(admin.TabularInline):
    model = SongFeatureArtist

class FollowingListInline(admin.TabularInline):
    fk_name = 'follower'
    model = FollowingList

class FollowerListInline(admin.TabularInline):
    fk_name = 'target'
    model = FollowingList

class PlaylistInline(admin.TabularInline):
    model = Playlist

class FollowedPlaylistInline(admin.TabularInline):
    model = FollowedPlaylist

class LikedSongInline(admin.TabularInline):
    model = LikedSong

class LikedAlbumInline(admin.TabularInline):
    model = LikedAlbum

class SongInline(admin.TabularInline):
    model = Song

class PlaylistSongInline(admin.TabularInline):
    model = PlaylistSong

@admin.register(Album)
class AlbumAdmin(admin.ModelAdmin):
    list_display = ['album_id', 'title', 'artist_username', 'album_length', 'number_of_likes', 'image_url', 'release_date' ]
    inlines = [LikedAlbumInline, SongInline]
    pass

@admin.register(Artist)
class ArtistAdmin(admin.ModelAdmin):
    list_display = ['username', 'monthly_listeners', 'rank', 'social_media_url']
    inlines = [AlbumInline, SongFeatureArtistInline, FavoriteArtistInline]
    pass

@admin.register(FavoriteArtist)
class FavoriteArtistAdmin(admin.ModelAdmin):
    list_display = ['person_username', 'artist_username', 'date_of_following']
    pass

@admin.register(FollowedPlaylist)
class FollowedPlaylistAdmin(admin.ModelAdmin):
    list_display = ['username', 'playlist', 'user_given_score']
    pass

@admin.register(FollowingList)
class FollowingListAdmin(admin.ModelAdmin):
    list_display = ['follower', 'target', 'date_of_following']
    pass

@admin.register(LikedAlbum)
class LikedAlbumAdmin(admin.ModelAdmin):
    list_display = ['username', 'album', 'user_given_score']
    pass

@admin.register(LikedSong)
class LikedSongAdmin(admin.ModelAdmin):
    list_display = ['username', 'song', 'user_given_score']
    pass

@admin.register(NormalUser)
class NormalUserAdmin(admin.ModelAdmin):
    list_display = ['username', 'last_played_song']
    inlines = [FavoriteArtistInline, FollowingListInline, FollowerListInline, PlaylistInline, FollowedPlaylistInline,
               LikedSongInline, LikedAlbumInline]
    pass

@admin.register(Playlist)
class PlaylistAdmin(admin.ModelAdmin):
    list_display = ['playlist_id', 'creator_username', 'title', 'number_of_followers', 'description', 'image_url']
    inlines = [FollowedPlaylistInline, PlaylistSongInline]
    pass

@admin.register(PlaylistSong)
class PlaylistSongAdmin(admin.ModelAdmin):
    list_display = ['playlist', 'song']
    pass

@admin.register(SongFeatureArtist)
class SongFeatureArtistAdmin(admin.ModelAdmin):
    list_display = ['artist_username', 'song']
    pass

@admin.register(Song)
class SongAdmin(admin.ModelAdmin):
    list_display = ['song_id', 'album', 'title', 'song_length', 'number_of_times_played' , 'song_url']
    inlines = [LikedSongInline, PlaylistSongInline, SongFeatureArtistInline]
    pass

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ['username', 'name', 'image_url', 'password']
    inlines = [ArtistInline, NormalUserInline]
    pass

