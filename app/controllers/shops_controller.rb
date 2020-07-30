class ShopsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_shop, only: [:show, :edit, :update] 

    def new 
        @shop = Shop.new  
        @shop.build_category 
    end 

    def create
        @shop = Shop.new(shop_params) 
        @shop.user_id = session[:user_id] 
   
       if @shop.save 
         redirect_to shop_path(@shop) 
       else
        @shop.build_category  
         render :new 
       end
     end

    def index   
      if params[:category_id]
        category = Category.find(params[:category_id])
        @shops = category.shops 
      
      else 
        @shops = Shop.order_by_rating.includes(:category) 
      end 
    end 

    def show 
    end 

    def edit 
      if authorized_to_edit?(@shop) 
       render :edit   
      else 
       redirect_to shop_path(@shop)   
      end
     end 

    def update   
      if @shop.update(shop_params)
        redirect_to shop_path(@shop)
      else
        render :edit
      end 
    end 
    def destroy
      @shop= Shop.find(params[:id])
      @shop.destroy
      redirect_to shop_path(@shop)
     end

    def most_popular 
      @shops = Shop.most_popular 
    end 

    private 

    def shop_params
        params.require(:shop).permit(:name, :price_range, :address, :category_id, category_attributes: [:name])
      end

    def set_shop
        @shop = Shop.find_by(id: params[:id])
        redirect_to shops_path if !@shop 
     end

     def redirect_if_not_authorized 
      if @shop.update(name: params[:name], price_range: params[:price_range], address: params[:address])   
        redirect_to shop_path(@shop)
      else
        redirect_to user_path(current_user)     
      end 
    end

end
