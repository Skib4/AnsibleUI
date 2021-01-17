class Host < ApplicationRecord
  belongs_to :run
  validates :hostname, presence: true
  validates :ip_addr, ipaddr: true, presence: true
  validates :ssh_port, presence: true
  validates :ssh_user, presence: true
  validates :passwordssh, presence: true
end
