from django.contrib import admin
from .models import Album, Artist, FavoriteArtist, FollowedPlaylist, FollowingList, LikedAlbum, \
    LikedSong, NormalUser, Playlist, PlaylistSong, SongFeatureArtist, Song, User
from django.db import connection
from django import forms
from django.contrib.admin.helpers import ActionForm

from datetime import date

from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from django.db.models.expressions import RawSQL


class TopTenArtistListFilter(admin.SimpleListFilter):
    title = _('Top Ten Artists')
    parameter_name = 'top10art'

    def lookups(self, request, model_admin):
        return (
            ('TT', _('Top Ten Artists')),
            ('NT', _('not in top ten'))
        )

    def queryset(self, request, queryset):
        if self.value() == 'TT':
            return queryset.filter(
                rank__in=RawSQL("""
                SELECT rank
                FROM artist
                WHERE rank < 11
                ORDER BY rank
                """, [])
            )
        if self.value() == 'NT':
            return queryset.filter(
                rank__in=RawSQL("""
                                SELECT rank
                                FROM artist
                                WHERE rank >= 11
                                ORDER BY rank
                                """, [])
            )



class XForm(ActionForm):
    x_field = forms.CharField()


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
    sortable_by = ['album_id', 'title', 'artist_username', 'album_length', 'number_of_likes', 'release_date']
    list_display = ['album_id', 'title', 'artist_username', 'album_length', 'number_of_likes', 'image_url',
                    'release_date']
    inlines = [LikedAlbumInline, SongInline]
    search_fields = ['title', 'album_id']
    pass


@admin.register(Artist)
class ArtistAdmin(admin.ModelAdmin):
    sortable_by = ['username', 'monthly_listeners', 'rank']
    list_display = ['username', 'monthly_listeners', 'rank', 'social_media_url']
    list_filter = [TopTenArtistListFilter]
    inlines = [AlbumInline, SongFeatureArtistInline, FavoriteArtistInline]
    pass


@admin.register(FavoriteArtist)
class FavoriteArtistAdmin(admin.ModelAdmin):
    list_display = ['person_username', 'artist_username', 'date_of_following']
    sortable_by = ['person_username', 'artist_username', 'date_of_following']
    pass


@admin.register(FollowedPlaylist)
class FollowedPlaylistAdmin(admin.ModelAdmin):
    sortable_by = ['username', 'playlist', 'user_given_score']
    list_display = ['username', 'playlist', 'user_given_score']
    pass


@admin.register(FollowingList)
class FollowingListAdmin(admin.ModelAdmin):
    sortable_by = ['follower', 'target', 'date_of_following']
    list_display = ['follower', 'target', 'date_of_following']
    pass


@admin.register(LikedAlbum)
class LikedAlbumAdmin(admin.ModelAdmin):
    sortable_by = ['username', 'album', 'user_given_score']
    list_display = ['username', 'album', 'user_given_score']
    pass


@admin.register(LikedSong)
class LikedSongAdmin(admin.ModelAdmin):
    sortable_by = ['username', 'song', 'user_given_score']
    list_display = ['username', 'song', 'user_given_score']
    pass


@admin.register(NormalUser)
class NormalUserAdmin(admin.ModelAdmin):
    list_display = ['username', 'last_played_song']
    sortable_by = ['username']
    inlines = [FavoriteArtistInline, FollowingListInline, FollowerListInline, PlaylistInline, FollowedPlaylistInline,
               LikedSongInline, LikedAlbumInline]
    action_form = XForm
    actions = ['print_to_terminal', 'sort_asc_by_id']

    @admin.action(description="""
    Print to terminal
    """)
    def print_to_terminal(self, request, qeryset):
        print(request.POST['x_field'])

    @admin.action(description="""
        Sort Asc by ID
        """)
    def sort_asc_by_id(self, request, qeryset):
        with connection.cursor() as query:
            query.execute(
                """
                SELECT NU.username
                FROM "SYMPHONYC".normal_user NU
                ORDER BY NU.username ASC;
                """
            )
            row = query.fetchone()
            print(row)
            NormalUser.objects.all().count()

    pass


@admin.register(Playlist)
class PlaylistAdmin(admin.ModelAdmin):
    sortable_by = ['playlist_id', 'creator_username', 'title', 'number_of_followers']
    list_display = ['playlist_id', 'creator_username', 'title', 'number_of_followers', 'description', 'image_url']
    search_fields = ['playlist_id', 'title']
    inlines = [FollowedPlaylistInline, PlaylistSongInline]
    pass


@admin.register(PlaylistSong)
class PlaylistSongAdmin(admin.ModelAdmin):
    sortable_by = ['playlist', 'song']
    list_display = ['playlist', 'song']
    pass


@admin.register(SongFeatureArtist)
class SongFeatureArtistAdmin(admin.ModelAdmin):
    sortable_by = ['artist_username', 'song']
    list_display = ['artist_username', 'song']
    pass


@admin.register(Song)
class SongAdmin(admin.ModelAdmin):
    sortable_by = ['song_id', 'album', 'title', 'song_length', 'number_of_times_played']
    list_display = ['song_id', 'album', 'title', 'song_length', 'number_of_times_played', 'song_url']
    search_fields = ['song_id', 'title']
    inlines = [LikedSongInline, PlaylistSongInline, SongFeatureArtistInline]
    pass


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    sortable_by = ['username', 'name']
    list_display = ['username', 'name', 'image_url', 'password']
    search_fields = ['username', 'name']
    inlines = [ArtistInline, NormalUserInline]
    pass
