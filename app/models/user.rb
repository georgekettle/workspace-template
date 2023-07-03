class User < ApplicationRecord
  has_person_name # gem 'person_name'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workspace_users, dependent: :destroy
  has_many :workspaces, through: :workspace_users

  validates :first_name, presence: true
  validates :last_name, presence: true
end
