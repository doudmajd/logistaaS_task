class AuthorsController < ApplicationController
  before_action :authenticate_author!

  def index
    @filterrific = initialize_filterrific(
      Author,
      params[:filterrific],
      select_options: {
      },
      persistence_id: false,
    ) or return

    @authors = @filterrific.find
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to @author, notice: "Author was successfully created."
    else
      render :new
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to @author, notice: "Author was successfully updated."
    else
      render :edit
    end
  end


  # def destroy
  #   @author = Author.find(params[:id])
  #   @author.destroy
  #   redirect_to authors_path, notice: 'Author was successfully deleted.'
  # end



  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :email, :password, :password_confirmation)
  end
end
