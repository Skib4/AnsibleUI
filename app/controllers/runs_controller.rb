class RunsController < ApplicationController

  def new
    @run = Run.new()
  end

  def create
    run = Run.new(run_params)
    if @run.save
      @run.save
      # Ustawiamy sesję/cookies aby zapamietac autorow
      session[:author] = @run.author
      # wartość wiadomości flashowej dodajemy w tym żądaniu lecz jej wartość zostanie wyświetlona w kolejnym (po przekierowaniu)
      flash[:notice] = "Run dodany pomyślnie"
    else
      render action: 'new'
    end
    redirect_to runs_path
  end

  def edit
    @run = Run.find(params[:id])
  end

  def index
    @runs = Run.all
    @hosts = Host.all
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
    params.require(:run).permit(:result, :command, :playbook_path)
  end

end
