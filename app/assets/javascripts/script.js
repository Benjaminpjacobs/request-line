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

            success: function(response) {
                var playlist = document.getElementById(playlistId)
                var trackList = document.createElement('ul')
                trackList.className = 'track-list'
                trackList.innerHTML = `<iframe src="https://open.spotify.com/embed?uri=spotify:user:${userId}:playlist:${playlistId}"width="400" height="300" frameborder="0" allowtransparency="true"></iframe>`
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