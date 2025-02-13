class Project < ApplicationRecord
	enum :current_status, { to_do: 0, in_progress: 1, completed: 2, on_hold: 3 }, default: :to_do, validate: true

  validates :name, presence: true

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
	has_many :interaction_logs, dependent: :destroy
end
