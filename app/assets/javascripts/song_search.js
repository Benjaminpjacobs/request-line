window.onload = function() {
    var songSearch = document.getElementById('song_query')
    var songSubmit = document.getElementById('song_query_submit')

    if (songSubmit !== null) {

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
                <p> by <span class='artist'>${artist}</span> on <span class='album'>${album}</span></p>
                <a rel='nofollow' data-method='post' href='/request?song_id=${id}'>Submit Request</a>
                `

                        results.appendChild(song)
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("Status: " + textStatus);
                    alert("Error: " + errorThrown);
                }
            })
        })
    }
}