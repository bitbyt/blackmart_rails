class StaticPagesController < ApplicationController
  def home
    @products = Product.all
    @brands = Brand.all
    @categories = Category.all
    @order_item = current_order.order_items.new
  end

  def about
  end

  def contact
  end
end
