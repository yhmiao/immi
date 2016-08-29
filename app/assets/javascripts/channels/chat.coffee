
jQuery(document).on 'turbolinks:load', ->
  messages = $('#chat-messages')

  if messages.length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
      channel: "ChatChannel"
      chat_token: messages.data('chat-token')
      },

      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        # Data received
        messages.append data['message']
        messages_to_bottom()

      speak: (message) ->
        @perform 'speak', message: message

    $('#new_message').submit (e) ->
      $this = $(this)
      msg = $this.find('#message_body')
      if $.trim(msg.val()).length > 1
        App.global_chat.speak msg.val()
        msg.val('')
      e.preventDefault()
      return false

