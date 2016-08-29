module ChatsHelper
	def chat_name(chat)
		chat.name.to_s == "" ? chat.users.where.not(users: {id: current_user.id}).pluck(:username).join(",") : chat.name
	end
end