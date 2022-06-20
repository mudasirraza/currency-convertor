class DashboardsController < ApplicationController
  before_action :setup_dashboard

  def index
  end

  def create
    if params[:currency_layer_convertor]
      @convertor = CurrencyLayer::Convertor.new(
        to_currency: permitted_params[:to_currency],
        input_number: permitted_params[:input_number]
      )

      if @convertor.valid?
        @convertor.convert!
      end
    end

    if params[:currency_layer_graph]
      @graph = CurrencyLayer::Graph.new(
        to_currency: permitted_graph_params[:to_currency]
      )
      
      if @graph.valid?
        @graph.setup_graph_data!
      end
    end

    respond_to do |format|
      format.html { render action: 'index' }
    end
  end

  private

  def permitted_params
    params.require(:currency_layer_convertor).permit(:to_currency, :input_number)
  end

  def permitted_graph_params
    params.require(:currency_layer_graph).permit(:to_currency)
  end

  def setup_dashboard
    @convertor = CurrencyLayer::Convertor.new
    @graph = CurrencyLayer::Graph.new(to_currency: 'USD')
    @graph.setup_graph_data! unless params[:currency_layer_graph]
  end
end
