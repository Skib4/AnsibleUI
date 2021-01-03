class Host < ApplicationRecord

  #  def ssh_range
  #   if(ssh_port = 22 || (ssh_port >1024 && ssh_port < 65535))
  #     end
  #   end


  validates :hostname, presence: true
  validates :ip_addr, ipaddr: true, presence: true
   #validates :ssh_port, presence: true, if: -> { :ssh_port.to_i == 22 || (:ssh_port.to_i > 1024 && :ssh_port.to_i < 65535) }
   validates :ssh_port, presence: true
   validates :ssh_user, presence: true
  validates :ssh_password, presence: true
  #validates_numericality_of :ssh_port, :equal_to => 22, :message => "Wrong SSH port! It must be 22 or >1024 "
  #validates_numericality_of :ssh_port, :greater_than_or_equal_to => 1025, :less_than_or_equal_to => 65535, :message => "Wrong SSH port! It must be 22 or >1024 "
  #validates_numericality_of :ssh_port, if => { equal_to: 22 || (greater_than: 1024 && less_than: 65535)}
end
