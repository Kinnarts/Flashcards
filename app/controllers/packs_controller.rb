class PacksController < ApplicationController
  before_action :find_pack, only: [:show, :edit, :update, :destroy]

  def index
    @packs = current_user.packs
  end

  def show
  end

  def new
    @pack = Pack.new
  end

  def create
    @pack = current_user.packs.new(pack_params)
    if @pack.save
      flash[:notice] = "Колода создана успешно"
      redirect_to packs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pack.update(pack_params)
      redirect_to packs_path
    else
      render :edit
    end
  end

  def destroy
    @pack.destroy
    redirect_to packs_path
  end

  private

  def find_pack
    @pack = current_user.packs.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:name, :user_id)
  end
end
