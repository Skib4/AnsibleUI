class RunsController < ApplicationController
  before_action :authenticate_user!, :refresh
  after_action :refresh
  
  def new
    @run = Run.new()
  end

  def create

  if ( run_params[:host_id] == nil )
      flash[:danger] = "Musisz wybrać co najmniej jednego hosta!"
      redirect_to new_run_path
  else

  @host_ids =   run_params[:host_id].map(&:clone)
  @bash_command = run_params[:command]

  if (@bash_command == nil)
    @host_ids.each  do |u|
        @run = Run.new(run_params)
        @run.author = current_user.name + " " + current_user.surname
        @playbook = Playbook.find(run_params[:playbook_id])
        @playbook_path = @playbook.path
        @playbook_id = @playbook.id
        @hostname = Host.find(u).hostname
        @command = "unbuffer ansible-playbook " + @playbook_path + " --limit " + @hostname +  " >> /etc/ansible/tmp/run_playbook_" + @playbook_id.to_s
        system(@command)
        @run.output = File.read("/etc/ansible/tmp/run_playbook_"+@playbook_id.to_s)
        system("rm -rf /etc/ansible/tmp/run_playbook_"+@playbook_id.to_s )
	@playbook.runsnumber += 1
        @playbook.save
        @run.host_id = "#{u}"
        @run.hostname = @hostname
        @run.playbook_path = @playbook_path
	@run.save
    end
	flash[:notice] = "Wykonano zadanie!"
        redirect_to runs_path
   else 
     @host_ids.each   do |u|
        @run = Run.new(run_params)
        @run.playbook_id=0
	@run.author = current_user.name + " " + current_user.surname
        @run.playbook_path = @bash_command
        @run.host_id = "#{u}"
        @hostname = Host.find(u).hostname
        @command_bash = 'unbuffer ansible '+@hostname+' -a "' + @bash_command + '" >> /etc/ansible/tmp/run_host_command'
	system(@command_bash)
        @run.output = File.read("/etc/ansible/tmp/run_host_command")
	system("rm -rf /etc/ansible/tmp/run_host_command")
	@run.hostname = @hostname
	@run.save
   end
       flash[:notice] = "Wykonano zadanie!"
       redirect_to runs_path
   end
   end
 end

  def edit
    @run = Run.find(params[:id])
  end

  def index
    @runs = Run.page(params[:page]).per(10)
  end

  def call_hosts
    @hosts = Host.all
  end

  def show
    @run = Run.find(params[:id])
  end

  def update
    @run = Run.find(params[:id])
    if @run.update_attributes(post_params)
      flash[:notice] = "Zedytowano post!"
      redirect_to posts_path
    else
      render action: 'edit'
    end
  end

  private

  def run_params
    params.require(:run).permit(:result, :command, :playbook_path, :author, :hostname, :ip_addr, :playbook_id, :host_id => [] )
  end
  
  def refresh
   system("rm -rf /etc/ansible/tmp/run_host_command && rm -rf /etc/ansible/tmp/run_playbook_*")
  end
end
