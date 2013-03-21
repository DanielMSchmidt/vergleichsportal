class HomeController < ApplicationController
  # TODO: After oder before filter?? render after view?
  after_filter :add_query, only: [:search_results]
  after_filter :filter_results, only: [:search_results]
  before_filter :add_rating

  def index
    @user_new = User.new
    @providers = Provider.all
  end

  def search_results
    @user_new = User.new
    if params[:search]
      @term = params[:search][:term]
    else
      @term = {}
    end
    
    if params[:options]
      @options = params[:option]
    else
      @options = {}
    end
    search = Search.new(@term, @options)

    @result = search.find.reject{|result| result == false || result.id.nil?}.uniq # TODO: Check where nils come from
  end

  def admin
    if @active_user.guest?
      redirect_to :root
    else
      @users = User.all.reject{|user| user.guest?}
      @providers = Provider.all
      @active_advertisments = Advertisment.active
      @inactive_advertisments = Advertisment.inactive
      @advertisment = Advertisment.new
    end
  end

  def track_compare
    @active_cart.compares.create
    render :json, nothing: true
  end

protected

  def add_query
    query = SearchQuery.create(value: @term, options: @options)
    query.articles = @result unless @result.nil?
    SearchQueryWorker.perform_in(2.hours, query)
  end

  def filter_results
    Rails.logger.info "HomeController#filter_results called"
    @result.select!{|article| article.available_for_any(Provider.where(active: true))} unless @result.nil?
  end

  def add_rating
    @current_rating = @active_user.ratings
  end
end
