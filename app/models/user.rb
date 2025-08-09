class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :body_stats, dependent: :destroy
  has_many :workout_plans_as_client, class_name: 'WorkoutPlan', foreign_key: :client_id, dependent: :destroy
  has_many :workout_plans_as_trainer, class_name: 'WorkoutPlan', foreign_key: :trainer_id, dependent: :destroy
end
