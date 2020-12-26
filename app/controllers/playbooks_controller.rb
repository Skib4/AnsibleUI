class PlaybooksController < ApplicationController
  #  before_action :authenticate_user!

  def new
    @playbook = Playbook.new(author: session[:author])
  end

  def create
    @X = params.require(:playbook).permit(:author, :body, :description, :url, :path, :name)
    @auth = @X['author']
    @bd = @X['body']
    @des = @X['description']
    @url = @X['url']
    @name =@X['name']
    @path = @X['path']
    @playbook = Playbook.new(playbook_params)

    if (@url == nil)
      @playbook.save
      File.open("/etc/ansible/playbooks/"+@name+".yaml", "w+") do |f|
        f.write(@bd+"\n")
        f.close
      end
      flash[:notice] = "Playbook dodany pomyślnie"
      redirect_to playbooks_path

    else if (@url != nil)
           @URL = "wget -O "+@name+".yaml -P /etc/ansible/playbooks/ "+@url
           @playbook.save
           system(@URL)
    end
    end
  end

  #Host.all.each do |host|
  #         @hstn = host.hostname
  #         @ip =  host.ip_addr
  #         @ssh= host.ssh_port
  #         File.open("/etc/ansible/hosts", "w+") do |f|
  #           f.write(@hstn +" "+@ip+" ansible_port="+@ssh.to_s+"\n")
  #           f.close
  #         end
  #
  def edit
    @playbook = Playbook.find(params[:id])
    @name = @playbook.name
    @data = File.read("/etc/ansible/playbooks/"+@name+".yaml")
  end

  def index
    @playbooks = Playbook.all
  end

  #def wget
  #  my_input = params['my_input']
  #  system("wget -P /etc/ansible/playbooks #{my_input}")
  #end

  def show
    @playbook = Playbook.find(params[:id])
  end

  def destroy
    @playbook = Playbook.find(params[:id])
    @playbook.destroy
    flash[:notice] = "Usunięto post!"
    redirect_to playbooks_path
  end

  def confirm_destroy
    @playbook = Playbook.find(params[:id])
  end

  def update
    @playbook = Playbook.find(params[:id])
    @name = @playbook.name
    @bd = @playbook.body

      if @playbook.update_attributes(playbook_params)
        File.open("/etc/ansible/playbooks/"+@name+".yaml", "w+") do |f|
          f.write(@bd+"\n")
          f.close
          end
        flash[:notice] = "Zedytowano playbooka!"
        redirect_to playbooks_path
      else

        render action: 'edit'
      end
  end

  private
  def playbook_params
    params.require(:playbook).permit(:author, :body, :description, :url, :path,:name)
  end

  end

