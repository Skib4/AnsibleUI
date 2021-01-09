class PostsController < ApplicationController
  before_action :authenticate_user!

# wszystkie poniższe akcje odpowiadają akcjom standardowego kontrolera rest'owego
  def new
    @post = Post.new(author: session[:author])
    @post.author= current_user.name + " " + current_user.surname
  end

# metoda do obsługi zapisywania nowych postów
  def create
    # kazdy model Active Record w konstruktorze może przyjąć hasha z wartościami wszystkich atrybutów które chcielibyśmy przypisać przy tworzeniu obiektu
    # strong parameters - oznacza które parametry są bezpieczne do przypisania w danym kontrolerze - tu przez metode post_params
    @post = Post.new(post_params)
    if @post.save
      @post.save
      # Ustawiamy sesję/cookies aby zapamietac autorow
      session[:author] = @post.author
      # wartość wiadomości flashowej dodajemy w tym żądaniu lecz jej wartość zostanie wyświetlona w kolejnym (po przekierowaniu)
      flash[:notice] = "Post dodany pomyślnie"
    else
      render action: 'new'
    end
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def published
    @posts = Post.where(published: true)
    render action: "index"
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Usunięto post!"
    redirect_to posts_path
  end

  def confirm_destroy
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
      if @post.update_attributes(post_params)
        flash[:notice] = "Zedytowano post!"
        redirect_to posts_path
      else
        render action: 'edit'
      end
  end

# t.string "author"
# t.boolean "published"
# t.date "created"
# t.text "body"

  private
  #metoda zwraca hasha w którym atrybuty które chcemy masowo przypisać zostaną oznaczone jako bezpieczne
  # title, author, body i published sa oznaczone jako bezpieczne atrybuty
  def post_params
    params.require(:post).permit(:title, :author, :body, :published)
  end

end
