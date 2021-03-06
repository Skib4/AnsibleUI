class PlaybooksController < ApplicationController
  before_action :authenticate_user!
  after_action :update_file
  before_action :update_file

  def new
    @playbook = Playbook.new(author: session[:author])
    @playbook.author= current_user.name + " " + current_user.surname
  end

  def create
    @playbook = Playbook.new(playbook_params)
    @X = params.require(:playbook).permit(:author, :body, :description, :url, :path, :name)
    @bd = @X['body']
    @url = @X['url']
    @name =@X['name']
    @playbook.path = "/etc/ansible/playbooks/"+@playbook.name+".yaml"
    @playbook.runsnumber = 0

    if (@playbook.name.match(/\s/))
       flash[:danger] = "Nazwa ma byc bez spacji!"
       redirect_to playbooks_path
    else

    if (@url == nil)
      File.open("/etc/ansible/playbooks/"+@name+".yaml", "w+") do |f|
        f.write(@bd+"\n")
        f.close
      end
      @playbook.save

      flash[:notice] = "Playbook dodany pomyślnie"
      redirect_to playbooks_path

    else if (@url != nil)
           @URL = "wget –P /etc/ansible/playbooks/ -O /etc/ansible/playbooks/"+@name+".yaml "+@url
           system("touch /etc/ansible/playbooks/"+@name+".yaml")
           system(@URL)
           @playbook.body = File.read("/etc/ansible/playbooks/"+@name+".yaml")
           @playbook.save
         end
    flash[:notice] = "Playbook dodany pomyślnie"
    redirect_to playbooks_path
    end
    end
  end

  def edit
    @playbook = Playbook.find(params[:id])
    @name = @playbook.name
    @data = File.read("/etc/ansible/playbooks/"+@name+".yaml")
  end

  def index
    @playbooks = Playbook.page(params[:page]).per(10)
  end

  def show
    @playbook = Playbook.find(params[:id])
  end

  def destroy
    @playbook = Playbook.find(params[:id])
    @playbook.destroy
    @name = @playbook.name
    system("rm -rf /etc/ansible/playbooks/"+@name+".yaml")
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
        system("rm -rf /etc/ansible/playbooks/"+@name+".yaml")

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
    params.require(:playbook).permit(:author, :body, :description, :url, :path, :name, :runsnumber, :host_id)
  end

  def update_file
    Playbook.all.each do |playbook|
      @name = playbook.name
      @body =  playbook.body
      @url = playbook.url

      system("rm -rf /etc/ansible/playbooks/"+@name+".yaml")
      File.open("/etc/ansible/playbooks/"+@name+".yaml", "w+") do |f|
        f.write(@body+"\n")
        f.close
      end
   end
  end

end
