class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /lists/1/items
  # GET /lists/1/items.json
  def index
    @items = @list.items
  end

  # GET /lists/1/items/1
  # GET /lists/1/items/1.json
  def show
  end

  # POST /lists/1/items
  # POST /lists/1/items.json
  def create
    @item = Item.new(item_params)

    if @list.items << @item
      render :show, status: :created, location: list_item_path(@list, @item)
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1/items/1
  # PATCH/PUT /lists/1/items/1.json
  def update
    if @item.update(item_params)
      render :show, status: :ok, location: list_item_path(@list, @item)
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1/items/1
  # DELETE /lists/1/items/1.json
  def destroy
    @item.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:list_id])
    end

    def set_item
      @item = @list.items.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :list_id)
    end
end
