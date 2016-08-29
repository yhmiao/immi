class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:edit, :update, :destroy]

  # GET /chats
  # GET /chats.json
  def index
    @chats = current_user.chats.all.order(id: :desc)
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
    @chat = current_user.chats.includes(messages: :user).find_by_token(params[:id])
    @message = Message.new
  end

  # GET /chats/new
  def new
    @chat = Chat.new
    @contacts = current_user.contacts.includes(:contactee).where.not(contactee: current_user)
  end

  # GET /chats/1/edit
  def edit
    @contacts = current_user.contacts.includes(:contactee).where.not(contactee: @chat.users)
  end

  # POST /chats
  # POST /chats.json
  def create
    @chat = current_user.chats.new(chat_params)

    @chat.chat_users.build(user: current_user)

    respond_to do |format|
      if @chat.save
        format.html { redirect_to chat_path(@chat.token), notice: 'Chat was successfully created.' }
        format.json { render :show, status: :created, location: @chat }
      else
        format.html { render :new }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to chat_path(@chat.token), notice: 'Chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    @chat.destroy
    respond_to do |format|
      format.html { redirect_to chats_url, notice: 'Chat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_personal
    @user = User.find_by_id(params[:id])
    @chat = current_user.chats.joins(:users).includes(:messages).where(chat_users_count: 2, users: {id: @user.id}).first
    if @chat.nil?
      @chat = current_user.chats.create!()
      @chat.users << @user
    end
    @message = Message.new

    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = current_user.chats.find_by_token(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_params
      params.fetch(:chat, {}).permit(:name, user_ids: [])
    end
end