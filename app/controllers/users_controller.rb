class UsersController < ApplicationController
	before_action :authenticate_user!

	def search
		@contact_search = OpenStruct.new()
		@contact_search.search = params.has_key?(:search)
		if @contact_search.search
			@contact_search.user = User.find_by_username(params[:search])
			if @contact_search.user
				@contact_search.in_contact = current_user.contactees.include?(@contact_search.user)
			end
		end
	end
end