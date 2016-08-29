class ChatUser < ApplicationRecord
	belongs_to :chat, counter_cache: true
	belongs_to :user
	has_many :messages
end