class Chat < ApplicationRecord
	has_many :chat_users, dependent: :destroy
	has_many :users, through: :chat_users
	has_many :messages, dependent: :destroy

	include Tokenable

	attr_accessor :user_ids

	after_save :create_chat_users

	def create_chat_users
		users = User.where(id: self.user_ids)
		users.map {|u| self.chat_users.create!(user_id: u.id) }
	end

	# def message_all(user,message)
	# 	self.users.each {|u| u.messages.create!(body: message, chat_id: self.id)} 
	# 	msg = user.messages.last
	# 	MessageBroadcastJob.perform_later(msg)
	# end
end