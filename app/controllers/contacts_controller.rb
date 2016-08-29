class ContactsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_contact, only: [:show, :edit, :update, :destroy]

	def index
		@contacts = current_user.contacts.includes(:contactee)
	end

	def create
		@contact = current_user.contacts.new(contactee_id: params[:contactee_id])

		if @contact.save
			redirect_to contacts_path
		else

		end
	end

	def show

	end

	private

	def set_contact
		@contact = current_user.contacts.find_by_id(params[:id])
	end
end
