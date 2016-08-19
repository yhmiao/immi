App.messenger = App.cable.subscriptions.create "MessengerChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#messages').append(data.message)

  speak: (msg) ->
    @perform 'speak', message: msg


$(document).on 'keypress', '#messenger-speak', (event) ->
  if event.keyCode is 13
    App.messenger.speak(event.target.value)
    event.target.value = ""
    event.preventDefault()
