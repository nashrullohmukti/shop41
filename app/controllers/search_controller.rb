class SearchController < ApplicationController
  def result
    q = (params[:term].present? && params[:term]) || '*'
    @products = Product.search(q , fields: [:name])
  end
end
