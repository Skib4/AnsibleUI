class Playbook < ApplicationRecord
  belongs_to :run
 # validates :name, :uniqueness => true, :presence => true, length: {
 #   maximum: 1,
 #   tokenizer: lambda { |str| str.split(/\s+/) },
 #   too_long: "Nazwa to jedno slowo lub wiecej slow polaczonych podlaga a nie %{count} slowa!"
 # }
  validates :name, :uniqueness => true, :presence => true
#validate :name_in_1_word
#
#  private
#
#	def name_in_1_word
#  	if name.to_s.squish.split.size != 1
#    		errors.add(:name, 'Wadliwa nazwa - tylko jedno slowo!')
#  	end
#	end
#
end
