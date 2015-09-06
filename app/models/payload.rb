class Payload < ActiveRecord::Base
  belongs_to :source
  belongs_to :url
  belongs_to :browser

  validates :digest, presence: true, uniqueness: true
end
