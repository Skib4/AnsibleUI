class RunsController < ApplicationController
  before_action :authenticate_user!

  def new
    @run = Run.new()
    @host = Host.all
    @playbook = Playbook.all
    @run.author= current_user.name + " " + current_user.surname
  end

  def create
  @host_ids =   run_params[:host_id].map(&:clone)

    @host_ids.each   do |u|
        @run = Run.new(run_params)
        @playbook = Playbook.find(run_params[:playbook_id])
        @playbook_path = @playbook.path
        @playbook_id = @playbook.id
        @hostname = Host.find(u).hostname

        @command = "ansible-playbook " + @playbook_path + " --limit " + @hostname +  " >> /etc/ansible/tmp/run_host_#{u}_playbook_" + @playbook_id.to_s
        system(@command)

        

        @playbook.runsnumber += 1
        @playbook.save

        @run.host_id = "#{u}"
        @run.hostname = @hostname
        @run.playbook_path = @playbook_path

        if @run.save
          @run.save
        else
          render action: 'new'
        end
    end
    redirect_to runs_path
  end

  def edit
    @run = Run.find(params[:id])
  end

  def index
    @runs = Run.all
    @hosts = Host.all
    @playbooks = Playbook.all
  end

  def execute
    # Musze wiedziec jakie sa:
    # a) hosty
    # b) playbook do wykonania
    # c) port ssh
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

end
