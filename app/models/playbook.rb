class Playbook < ApplicationRecord
  belongs_to :run
  validates :name, :presence => true
end
