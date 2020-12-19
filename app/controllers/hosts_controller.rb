class HostsController < ApplicationController
  before_action :authenticate_user!

# wszystkie poniższe akcje odpowiadają akcjom standardowego kontrolera rest'owego
def new
  @host = Host.new(author: session[:author])
end

#metoda do obsługi zapisywania nowych hostów
def create
  #kazdy model Active Record w konstruktorze może przyjąć hasha z wartościami wszystkich atrybutów które chcielibyśmy przypisać przy tworzeniu obiektu
  # strong parameters - oznacza które parametry są bezpieczne do przypisania w danym kontrolerze - tu przez metode post_params
  @host = Host.new(host_params)
  if @host.save
    @host.save
    #Ustawiamy sesję/cookies aby zapamietac hostname'y
    session[:hostname] = @host.hostname
    # wartość wiadomości flashowej dodajemy w tym żądaniu lecz jej wartość zostanie wyświetlona w kolejnym (po przekierowaniu)
    flash[:notice] = "Host dodany pomyślnie"
  else
    render action: 'new'
  end
  redirect_to hosts_path
end

def edit
  @host = Host.find(params[:id])
  file = File.open("/etc/ansible/hosts")
end

def index
  @hosts = Host.all
end

def published
  @hosts = Host.where(published: true)
  render action: "index"
end

def show
  @host = Host.find(params[:id])
end

def destroy
  @host = Host.find(params[:id])
  @host.destroy
  flash[:notice] = "Usunięto hosta!"
  redirect_to hosts_path
end

def confirm_destroy
  @host = Host.find(params[:id])
end

def update
  @host = Host.find(params[:id])
    if @host.update_attributes(host_params)
      flash[:notice] = "Zedytowano hosta!"
      redirect_to hosts_path
    else
      render action: 'edit'
    end
end

private
#metoda zwraca hasha w którym atrybuty które chcemy masowo przypisać zostaną oznaczone jako bezpieczne
# title, author, body i published sa oznaczone jako bezpieczne atrybuty
def host_params
  params.require(:host).permit(:hostname, :address)
end

end
