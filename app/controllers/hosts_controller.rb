class HostsController < ApplicationController
  # before_action :authenticate_user!
  #
  def index
    @hosts = Host.all
    respond_to do |format|
      format.html { }
      format.xml { }
      format.json { render json: @hosts.map { |h| { id: h.id, hostname: h.hostname, ip_addr: h.ip_addr, ssh_port: h.ssh_port, description: h.description } } }
    end
  end

def new
  @host = Host.new()
end

def create
  @X =  params.require(:host).permit(:hostname, :ip_addr, :description, :ssh_port)
  @hstn = @X['hostname']
  @ip = @X['ip_addr']
  @ssh = @X['ssh_port']
  @host = Host.new(host_params)

  if @host.save
    @host.save
    File.open("/etc/ansible/hosts", "a") do |f|
      f.write(@hstn +" "+@ip+" ansible_port="+@ssh+"\n")
      f.close
    end

    flash[:notice] = "Host dodany pomyślnie"
  else
    render action: 'new'
  end
    redirect_to hosts_path
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
    #@X =  params.require(:host).permit(:hostname, :ip_addr, :description, :ssh_port)
    @host = Host.find(params[:id])
    @hstn = @host.hostname
    @ip = @host.ip_addr
    @ssh = @host.ssh_port
    @id = @host.id
    #@timestamp="$(date +"%d%m%Y%H%M%S")"
    #dopisać ifa gdyby hostname nie działał
    @command_telnet ="echo -e '\x1dclose\x0d' |"+ @ip+" "+@ssh.to_s+" > /etc/ansible/tmp/telnet_"+@id.to_s
    @command_ping ="ping -c 4 "+ @ip + " > /etc/ansible/tmp/ping_"+@id.to_s
    system(@command_ping)
    system(@command_telnet)
    @data_ping = File.read("/etc/ansible/tmp/ping_"+@id.to_s)
    @data_telnet = File.read("/etc/ansible/tmp/telnet_"+@id.to_s)
  end

  def destroy
    Host.find(params[:id]).destroy

     if Host.find(params[:id]).destroy
      flash[:notice] = "Usunięto hosta!"
      system("rm -rf /etc/ansible/hosts")
      Host.all.each do |host|
        @hstn = host.hostname
        @ip =  host.ip_addr
        @ssh= host.ssh_port
        File.open("/etc/ansible/hosts", "w+") do |f|
          f.write(@hstn +" "+@ip+" ansible_port="+@ssh.to_s+"\n")
          f.close
        end
        end
      redirect_to hosts_path
    else
      flash[:notice] = "Blad usuwania"
    end
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
          f.write(@hstn +" "+@ip+" ansible_port="+@ssh.to_s+"\n")
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
   params.require(:host).permit(:hostname, :ip_addr, :description, :ssh_port)
  end
end