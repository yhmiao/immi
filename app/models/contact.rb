class Contact < ApplicationRecord
	belongs_to :user
	belongs_to :contactee, class_name: "User"

	delegate :id, :username, to: :contactee, prefix: :contactee
end