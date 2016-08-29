class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  def timestamp
  	self.created_at.strftime('%H:%M')
  end
end
