class PlaybooksController < ApplicationController
  before_action :authenticate_user!

# wszystkie poniższe akcje odpowiadają akcjom standardowego kontrolera rest'owego

#wszystkie poniższe akcje odpowiadają akcjom standardowego kontrolera rest'owego
  def new
    @playbook = Playbook.new(author: session[:author])
  end

#metoda do obsługi zapisywania nowych playbooków
  def create
    #kazdy model Active Record w konstruktorze może przyjąć hasha z wartościami wszystkich atrybutów które chcielibyśmy przypisać przy tworzeniu obiektu
    # strong parameters - oznacza które parametry są bezpieczne do przypisania w danym kontrolerze - tu przez metode playbook_params
      @playbook = Playbook.new(playbook_params)
    if @playbook.save
      @playbook.save
      #Ustawiamy sesję/cookies aby zapamietac autorow
      session[:author] = @playbook.author
      # wartość wiadomości flashowej dodajemy w tym żądaniu lecz jej wartość zostanie wyświetlona w kolejnym (po przekierowaniu)
      flash[:notice] = "Playbook dodany pomyślnie"
    else
      render action: 'new'
    end
    redirect_to playbooks_path
  end

  def edit
    @playbook = Playbook.find(params[:id])
  end

  def index
    @playbooks = Playbook.all
  end

  def wget
    my_input = params['my_input']
    system("wget -P /etc/ansible/playbooks #{my_input}")
  end
  helper_metodh :wget

#  def published
#    @playbooks = Playbook.where(published: true)
#    render action: "index"
#  end

  def show
    @playbook = Playbook.find(params[:id])
    @data = ''
    f = File.open(filename, "r")
    f.each_line do |line|
      data += line
    end
    return data
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
      if @playbook.update_attributes(playbook_params)
        flash[:notice] = "Zedytowano playbooka!"
        redirect_to playbooks_path
      else
        render action: 'edit'
      end
  end

  private
  #metoda zwraca hasha w którym atrybuty które chcemy masowo przypisać zostaną oznaczone jako bezpieczne
  # title, author, body i published sa oznaczone jako bezpieczne atrybuty
  def playbook_params
    params.require(:playbook).permit(:author, :body, :my_input)
  end

end
