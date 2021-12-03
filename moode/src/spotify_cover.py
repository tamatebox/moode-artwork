import spotipy, os, sys, subprocess, shutil
from spotipy.oauth2 import SpotifyOAuth
from dotenv import load_dotenv
import urllib.error
import urllib.request

PREVALBUMFILE="../txt/prev_song.txt"
DEFAULTCOVER='../img/default_cover.jpg'
TMPCOVER='../img/tmp_art.jpg'
RESOLUTION = int(sys.argv[1])
prev_song = sys.argv[2]

load_dotenv()
os.environ["SPOTIPY_CLIENT_ID"] = os.getenv('SPOTIPY_CLIENT_ID')
os.environ["SPOTIPY_CLIENT_SECRET"] = os.getenv('SPOTIPY_CLIENT_SECRET')
os.environ["SPOTIPY_REDIRECT_URI"] = "https://example.com/callback/"

def download_file(url, dst_path):
    try:
        with urllib.request.urlopen(url) as web_file, open(dst_path, 'wb') as local_file:
            local_file.write(web_file.read())
    except:
        shutil.copy(DEFAULTCOVER, TMPCOVER)

scope = "user-read-currently-playing"
cache_handler = spotipy.cache_handler.CacheFileHandler(cache_path="./.sp_cache")
auth_manager = SpotifyOAuth(scope=scope, cache_handler=cache_handler,show_dialog=True)
sp = spotipy.Spotify(auth_manager=auth_manager)
current_playing = sp.currently_playing(additional_types='episode')

try:
    current_artist = current_playing['item']['artists'][0]['name']
    current_album = current_playing['item']['album']['name']
    track_cover = current_playing['item']['album']['images'][0]['url']
except KeyError:
    current_artist = current_playing['item']['show']['publisher']
    current_album = current_playing['item']['show']['name']
    track_cover = current_playing['item']['show']['images'][0]['url']

except:
    subprocess.run(['convert', DEFAULTCOVER, '-resize', '{}x{}'.format(RESOLUTION, RESOLUTION), TMPCOVER])
    sys.exit()

current_song = "{}-{}".format(current_artist, current_album)
if prev_song == current_song:
    sys.exit()
else:
    download_file(track_cover, TMPCOVER)
    subprocess.run(['convert', TMPCOVER, '-resize', '{}x{}'.format(RESOLUTION, RESOLUTION), TMPCOVER])
    f = open(PREVALBUMFILE, 'w')
    f.write(current_song)
    f.close()