document.onready = function() {
    var playlistExpand = document.getElementsByClassName('expand')

    var getPlaylistTracks = function(playlist, hideButton) {
        var playlistId = playlist.getAttribute("id");
        var userId = playlist.firstElementChild.innerText;
        $.getJSON({
            url: 'http://localhost:3000/playlist/search',
            data: {
                playlist_id: playlistId,
                user_id: userId,
            },
            success: function(response, label) {
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
                hideButton.innerHTML = 'Hide'
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("Status: " + textStatus);
                alert("Error: " + errorThrown);
            }
        })
    };

    for (var i = 0; i < playlistExpand.length; i++) {
        playlistExpand[i].addEventListener('click', function() {
            var playlist = this.parentNode.parentNode.previousElementSibling;
            if (playlist.children.length === 1) {
                var hideButton = this
                getPlaylistTracks(playlist, hideButton)
            } else {
                var list = playlist.children[1];
                playlist.removeChild(list);
                this.innerHTML = 'Expand'
            }
        }, false);
    }
}