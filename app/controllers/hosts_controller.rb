class HostsController < ApplicationController
  before_action :authenticate_user!, :refresh_file
  after_action :refresh, :refresh_file
  require 'active_support'

  #include BCrypt

#  def encrypt(text)
#    text = text.to_s unless text.is_a? String
#    len   = ActiveSupport::MessageEncryptor.key_len
#    salt  = SecureRandom.hex len
#    key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
#    crypt = ActiveSupport::MessageEncryptor.new key
#    encrypted_data = crypt.encrypt_and_sign text
#    "#{salt}$$#{encrypted_data}"
#  end

#  def decrypt(text)
#    salt, data = text.split "$$"
#    len   = ActiveSupport::MessageEncryptor.key_len
#    key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
#    crypt = ActiveSupport::MessageEncryptor.new key
#    crypt.decrypt_and_verify data
#  end

  def index
    @hosts = Host.all
  end

  def new
    @host = Host.new()
    @host.author= current_user.name + " " + current_user.surname
  end

  def confirm_ssh
    @host = Host.find(params[:id])
  end

  def create
    @X =  params.require(:host).permit(:hostname, :ip_addr, :description, :ssh_port, :ssh_user, :passwordssh)
    @hstn = @X['hostname']
    @ip = @X['ip_addr']
    @ssh = @X['ssh_port']
    #@pass = @X['passwordssh']
    @host = Host.new(host_params)

    if @host.save
      @host.save
      File.open("/etc/ansible/hosts", "a") do |f|
        f.write(@hstn +" "+@ip+" ansible_port="+@ssh+"\n")
        f.close
      end
    flash[:notice] = "Host dodany pomyślnie"
      redirect_to hosts_path
    else
      render action: 'new'
    end
    #redirect_to hosts_path
  end

  def edit
    @host = Host.find(params[:id])
  end

  def show
    @host = Host.find(params[:id])
  end

  def confirm_destroy
     @host = Host.find(params[:id])
  end

  def test
    @host = Host.find(params[:id])
    @hstn = @host.hostname
    @ip = @host.ip_addr
    @ssh = @host.ssh_port
    @id = @host.id

    #sprawdzenie łączności pingiem i telnetem
    @command_telnet ="echo quit | timeout --signal=9 2 telnet "+ @ip+" "+@ssh.to_s+" > /etc/ansible/tmp/telnet_"+@id.to_s
    @command_ping ="ping -c 4 "+@ip+" > /etc/ansible/tmp/ping_"+@id.to_s

    # sprawdzenie czy frazy ktore oznaczaja blad polaczenia sie pojawily
    @ping_file_pre_test="cat /etc/ansible/tmp/ping_"+@id.to_s+" | grep '4 packets transmitted, 0 packets received' > /etc/ansible/tmp/ping_pre_"+@id.to_s

    #jezeli ww frazy sie nie pojawily to pojawi sie bledy
    @ping_file_test ="[ -s /etc/ansible/tmp/ping_pre_"+@id.to_s+" ] &&  echo '\nTest connection failed' >> /etc/ansible/tmp/PING_OUT || echo '\nTest connection successful' >> /etc/ansible/tmp/PING_OUT "
    @telnet_file_test ="[ -s /etc/ansible/tmp/telnet_"+@id.to_s+" ] && echo '\nTest connection successful' > /etc/ansible/tmp/TELNET_OUT || echo '\nTest connection failed' > /etc/ansible/tmp/TELNET_OUT "

    @test_ping="cat /etc/ansible/tmp/PING_OUT >> /etc/ansible/tmp/ping_"+@id.to_s
    @test_telnet="cat /etc/ansible/tmp/TELNET_OUT >> /etc/ansible/tmp/telnet_"+@id.to_s

    system(@command_ping)
    system(@ping_file_pre_test)
    system(@ping_file_test)
    system(@test_ping)

    system(@command_telnet)
    system(@telnet_file_test)
    system(@test_telnet)

  end

#  def ssh
#    @host = Host.find(params[:id])
#    @host.update_attributes(ssh_params)
#    redirect_to hosts_path
#  end

  def ssh
    @host = Host.find(params[:id])
    #@ip_addr = @host.ip_addr
    #@ssh_port = @host.ssh_port
    #@ssh_user = @host.ssh_user
    #@ssh_password = @host.passwordssh
    #@host = Host.find(params[:id])
    #@savepass = "echo "+@password+" > /etc/ansible/tmp/pass"
    #@ssh_command ="sshpass -p " + @ssh_password + " ssh-copy-id "+@ssh_user+"@"+@ip+" -p"+@ssh_port+" > /etc/ansible/tmp/ssh_"+@id
    @ssh_command ="sshpass -p " + @host.passwordssh + " ssh-copy-id -o StrictHostKeyChecking=no "+@host.ssh_user+"@"+@host.ip_addr+" -p"+@host.ssh_port.to_s+" > /etc/ansible/tmp/ssh_"+@host.id.to_s
    system(@ssh_command)
    redirect_to hosts_path

  end

  def destroy
    @host = Host.find(params[:id])
    @host.destroy
    flash[:danger] = "Usunięto hosta!"
#    render action: 'edit_file'
    redirect_to hosts_path
  end

  def update
  @host = Host.find(params[:id])
    if @host.update_attributes(host_params)
      flash[:notice] = "Zedytowano hosta!"
      system("rm -rf /etc/ansible/hosts")

      Host.all.each do |host|
        @hstn = host.hostname
        @ip =  host.ip_addr
        @ssh= host.ssh_port

        File.open("/etc/ansible/hosts", "a") do |f|
          f.write(@hstn +" ansible_host="+@ip+" ansible_port="+@ssh.to_s+"\n")
          f.close
        end
      end
      redirect_to hosts_path
    else
        render action: 'edit'
    end
  end


private

  def host_params
   params.require(:host).permit(:hostname, :ip_addr, :description, :ssh_port, :ssh_user, :passwordssh)
  end

  def refresh
    system("rm -rf /etc/ansible/tmp/ping_* && rm -rf /etc/ansible/tmp/telnet_* && rm -rf /etc/ansible/tmp/PING* && rm -rf /etc/ansible/tmp/TELNET*")
  end

  def refresh_file
    system("rm -rf /etc/ansible/hosts")
    Host.all.each do |host|

      @hstn = host.hostname
      @ip =  host.ip_addr
      @ssh= host.ssh_port

      File.open("/etc/ansible/hosts", "a+") do |f|
        f.write(@hstn +" ansible_host="+@ip+" ansible_port="+@ssh.to_s+"\n")
        f.close
      end
    end
  end

end
