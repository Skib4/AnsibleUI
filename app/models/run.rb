class Run < ApplicationRecord
  has_one :playbook
  has_many :hosts
  accepts_nested_attributes_for :playbook
  accepts_nested_attributes_for :hosts

#  before_validation do |model|
#    model.subset_array.reject!(&:blank?) if model.subset_array
#  end


end
