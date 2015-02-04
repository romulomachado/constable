var socket = new Phoenix.Socket("/ws")
var constableChannel

socket.join("announcements", {}, function(channel) {
  constableChannel = channel

  channel.on("announcements:index", function(payload) {
    console.log('index', payload.announcements)
  })

  channel.on("announcements:create", function(announcement) {
    console.log('create', announcement)
  })

  channel.on("error", function(error) {
    console.log("Failed to join topic. Reason: " + error.reason)
  })
});
