# == Schema Information
#
# Table name: tourn_summaries
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  text_file     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  error_message :string
#  aasm_state    :string           not null
#
# Indexes
#
#  index_tourn_summaries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class TournSummary < ApplicationRecord
  include AASM

  mount_uploader :text_file, TournSummaryUploader

  belongs_to :user
  has_one :game

  aasm do
    state :created, initial: true
    state :processing
    state :failed
    state :successful

    event :process do
      transitions from: [:created, :failed], to: :processing
    end

    event :fail do
      transitions from: :processing, to: :failed
    end

    event :success do
      transitions from: :processing, to: :successful
    end
  end

  def file_path
    text_file.current_path
  end

  def fail_with_errors!(errors = ['No errors present'])
    error_message ||= []
    error_message += errors
    fail!
  end
end
