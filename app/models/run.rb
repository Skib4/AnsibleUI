class Run < ApplicationRecord
  has_one :playbook
  has_many :hosts
  accepts_nested_attributes_for :playbook
  accepts_nested_attributes_for :hosts
  validates :playbook_id, presence: true
  validates :host_id, presence: true
end
