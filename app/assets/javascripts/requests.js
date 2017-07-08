document.onready = function() {
    var outgoing = document.querySelector('.outgoing')
    var incoming = document.querySelector('.incoming')
    outgoing.addEventListener('click', function() {
        $("#outgoing-requests").toggle();
        $("#incoming-requests").toggle();

    })
    incoming.addEventListener('click', function() {
        $("#incoming-requests").toggle();
        $("#outgoing-requests").toggle();

    })
}