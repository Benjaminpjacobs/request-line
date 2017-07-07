window.onload = function() {
    var songSearch = document.getElementById('song_query')
    var songSubmit = document.getElementById('song_query_submit')
    var playlistTitles = document.getElementsByClassName('playlist-title')

    songSubmit.addEventListener('click', function(e) {
        $.getJSON({
            url: 'http://localhost:3000/song/search',
            data: {
                q: songSearch.value,
            },
            success: function(response) {
                var results = document.getElementById('search-results')
                results.innerHTML = ''
                for (var i = 0; i < 10; i++) {
                    var song = document.createElement('div')
                    song.className = 'song'

                    var name = response[i].name
                    var album = response[i].album.name
                    var artist = response[i].album.artists[0].name
                    var id = response[i].id

                    song.innerHTML =
                        `<h3>${name}</h3> 
                         <p> by <span class='artist'>${artist}</span> on <span class='album'>${album}</span></p>`

                    results.appendChild(song)
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("Status: " + textStatus);
                alert("Error: " + errorThrown);
            }
        })
    })


    var getPlaylistTracks = function(playlist) {
        var playlistId = playlist.getAttribute("id");
        var userId = playlist.firstElementChild.innerText;
        //getjson
        $.getJSON({
            url: 'http://localhost:3000/playlist/search',
            data: {
                playlist_id: playlistId,
                user_id: userId,
            },
            success: function(response) {
                var playlist = document.getElementById(playlistId)
                var trackList = document.createElement('ul')
                trackList.className = 'track-list'
                for (var i = 0; i < response.length; i++) {
                    var track = document.createElement('li')
                    track.className = 'track'
                    var name = response[i].track.name
                    var artist = response[i].track.artists[0].name

                    track.innerHTML = `<p> <span class='track_name'>${name}</span> by <span class='artist'>${artist}</span></p>`
                    trackList.appendChild(track)
                }
                playlist.appendChild(trackList)
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("Status: " + textStatus);
                alert("Error: " + errorThrown);
            }
        })
    };

    for (var i = 0; i < playlistTitles.length; i++) {
        playlistTitles[i].addEventListener('click', function() {
            if (this.children.length === 1) {
                console.log(this)
                getPlaylistTracks(this)
            } else {
                var list = this.children[1];
                this.removeChild(list);
            }
        }, false);
    }
}