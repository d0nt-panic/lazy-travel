# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  nickname        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tourn_summaries :json
#

class User < ApplicationRecord
  mount_uploaders :tourn_summaries, TournSummaryUploader
  has_many :games, dependent: :destroy

  def self.create_form_schema
    Dry::Validation.Schema do
      required(:nickname).filled
    end
  end
end
