# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chat_#{params['chat_token']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    chat = current_user.chats.find_by_token(params['chat_token'])
    chat.messages.create!(body: data['message'], user_id: current_user.id)
    # chat.message_all(current_user,data['message'])
  end
end