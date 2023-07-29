class KittensController < ApplicationController
  before_action :set_kitten, except: %i[index new create]

  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def create
    @kitten = Kitten.new(kitty_params)

    if @kitten.save
      redirect_to @kitten, notice: 'Kitten Successfully Created.'
    else
      render :new
    end
  end

  def update
    if @kitten.update(kitty_params)
      redirect_to @kitten, notice: 'Kitten successfully updates.'
    else
      render :edit
    end
  end

  def destroy
    if @kitten.destroy
      redirect_to kittens_path, notice: 'Kitten successfully destroyed.'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to destroy the kitten.', status: :see_other
    end
  end

  private

  def set_kitten
    @kitten = Kitten.find(params[:id])
  end

  def kitty_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
