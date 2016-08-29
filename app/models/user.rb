class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :contactees, through: :contacts

  validates :username, presence: true

  after_create :create_self_contact

  def create_self_contact
    self.contacts.create!(contactee_id: self.id)
  end
end
