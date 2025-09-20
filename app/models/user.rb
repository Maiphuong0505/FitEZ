class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :body_stats, dependent: :destroy
  has_many :workout_plans_as_client, class_name: 'WorkoutPlan', foreign_key: :client_id, dependent: :destroy
  has_many :workout_plans_as_trainer, class_name: 'WorkoutPlan', foreign_key: :trainer_id, dependent: :destroy
  has_many :workout_sessions_as_client, through: :workout_plans_as_client, source: :workout_sessions
  has_many :workout_sessions_as_trainer, through: :workout_plans_as_trainer, source: :workout_sessions
  has_many :comments, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :contracts_as_client, class_name: 'Contract', foreign_key: :client_id, dependent: :destroy
  has_many :contracts_as_trainer, class_name: 'Contract', foreign_key: :trainer_id, dependent: :destroy

  has_one_attached :photo

  scope :my_clients, lambda { |trainer_id|
    where(is_a_trainer: false)
      .joins("LEFT JOIN workout_plans ON workout_plans.client_id = users.id")
      .joins("LEFT JOIN contracts ON contracts.client_id = users.id")
      .where("workout_plans.trainer_id = :id OR contracts.trainer_id = :id", id: trainer_id)
      .distinct
  }

  def trainer?
    is_a_trainer
  end
end
