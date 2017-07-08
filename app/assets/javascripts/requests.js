document.onready = function() {
    var outgoing = document.querySelector('.outgoing')
    var incoming = document.querySelector('.incoming')
    var incomingRequests = document.getElementById("incoming-requests")
    var outgoingRequests = document.getElementById("outgoing-requests")

    if (outgoing !== null && incoming !== null) {

        outgoing.addEventListener('click', function() {
            $("#outgoing-requests").toggle();

        })
        incoming.addEventListener('click', function() {
            $("#incoming-requests").toggle();

        })
    }
}