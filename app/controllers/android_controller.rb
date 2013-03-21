class AndroidController < ApplicationController
	skip_before_filter :set_active_user
  	skip_before_filter :set_active_cart
  	skip_before_filter :set_user_carts
  	skip_before_filter :fetch_add
  	skip_before_filter :set_providers
  	skip_before_filter :set_cart_providers
  	skip_before_filter :log_locked_user_out

  	skip_after_filter :setGuestUserInCookies
  	skip_after_filter :setActiveCartInCookies

	def default_serializer_options
		{root: false}
	end

	########## UsersAPIController methods ##########

	# used for login with username and password as POST request
	# returns status codes which will be mapped by the app to concrete error messages
	def check_auth
		if user = login(params[:username],params[:password])
			if (!user.active)
				render :json => [], :status => :forbidden
			else 
				render :json => ["userid" => user.id], :status => :accepted
			end
		else
			user = User.find_by_email(params[:username])
			if (user != nil)
				# activation state was removed from our domain but may come back
				#if (user.activation_state != "active")
				#	render :json => [], root: false, :status => :failed_dependency
				#else
					render :json => [], :status => :unauthorized
				#end
			else
				render :json => [], :status => :not_found
			end
		end
	end

	# used for registration of a new user as POST request
	# returns status codes which will be mapped by the app to concrete error messages
	def register
		user = User.find_by_email(params[:user][:email])
		if (user != nil)
			render :json => [], :status => :conflict
		else
			user_new = User.new(params[:user])
    		user_new.role_id = 1
    		if user_new.save
    			render json: [], status: :created
    		else
    			render json: [], status: :internal_server_error
    		end
		end
	end

	######## ProviderAPIController methods ##########

	# used for receiving all active providers as GET request
	# returns a json array string of all active providers
	def provider
		providers = Provider.where(active: true)
		#providers = Provider.all;
		if (providers != nil)
			render json: providers, each_serializer: ProviderForAndroidSerializer, status: :ok
		else
			render json: [], status: :ok
		end
	end

	# used to save a made rating for a provider as POST request
	# returns status codes which symbols success or failure of giving the rating (must be interpreted by the app)
	def rate_provider
		provider = Provider.find(params[:provider_id])
		if (provider != nil)
			rating = Rating.new(:value => params[:rating],:user_id => params[:user_id], :provider_id => provider.id)
			rating.save
		    provider.ratings << rating
		    provider.save
		    render json: ["rating" => provider.average_rating, "ratecount" => provider.ratings.size], status: :accepted
		else
			render json: [], status: :not_found
		end
	end

	######## ArticleAPIController methods ##########

	def debug
		unless params[:search].nil?
	      term = params[:search][:term] 
	    else
	      term = "Erweiterte Suche"
	    end
	    options = {"title" => "illuuminati"}  
	    search = Search.new(term, options)
	    result = search.find.reject{|result| result == false || result.id.nil?}.uniq
	    # cache the query
	    query = SearchQuery.create(value: term, options: options)
	    query.articles = result unless result.nil?
	    SearchQueryWorker.perform_in(2.hours, query)
	    # filter the result for active providers
	    result.select!{|article| article.available_for_any(Provider.where(active: true))} unless @result.nil?
	    # render result
	    render json: result, each_serializer: ArticleForAndroidSerializer, status: :ok
	end

	def search
		unless params[:search][:ean].nil?
	      term = params[:search][:ean]
	      options = {}
	    else
	      term = "Erweiterte Suche"
	      options = params[:search][:options]
	    end
	    search = Search.new(term, options)
	    result = search.find.reject{|result| result == false || result.id.nil?}.uniq
	    # cache the query
	    query = SearchQuery.create(value: term, options: options)
	    query.articles = result unless result.nil?
	    SearchQueryWorker.perform_in(2.hours, query)
	    # filter the result for active providers
	    result.select!{|article| article.available_for_any(Provider.where(active: true))} unless @result.nil?
	    # render result
	    render json: result, each_serializer: ArticleForAndroidSerializer, status: :ok
	end

	# used to save a made rating for an article as POST request
	# returns status codes which symbols success or failure of giving the rating (must be interpreted by the app)
	def rate_article
		article = Article.find(params[:article_id])
		if (article != nil)
		    rating = Rating.new(:value => params[:rating],:user_id => params[:user_id], :rateable_id => article.id, :rateable_type => "article")
		    rating.save
		    article.ratings << rating
		    article.save
		    render json: ["rating" => article.average_rating, "ratecount" => article.ratings.size], status: :created
		else
			render json: [], status: :not_found
		end
	end

	# used to save a made comment for an article as POST request
	# returns status codes which symbols success or failure of giving the comment (must be interpreted by the app)
	def comment_article
		article = Article.find(params[:article_id])
		if (article != nil)
		    comment = Comment.new(:value => params[:comment],:user_id => params[:user_id], :commentable_id => article.id, :commentable_type => "article")
		    article.add_comment(comment)
		    render json: [], status: :created
		else
			render json: [], status: :not_found
		end
	end

	def comments_for_article
		comments = Comment.where(commentable_id: params[:article_id], commentable_type: "Article")
		if (comments != nil)
			render json: comments, each_serializer: ArticleCommentForAndroidSerializer, status: :ok
		else
			render json: [], status: :ok
		end
	end

	def articles_for_cart
		if (params[:cart_id]==-1)
			render json: [], status: :ok
		else
			cart = Cart.find(params[:cart_id])
			if (cart != nil)
				render json: cart.article_cart_assignments, each_serializer: ArticleInCartForAndroidSerializer, status: :ok
			else
				render json: [], status: :ok
			end
		end
	end

	######## CartAPIController methods ##########

	def all_carts
		carts = Cart.where(user_id: params[:user_id])
		if (carts != nil)
			render json: carts, each_serializer: CartForAndroidSerializer, status: :ok
		else
			render json: [], status: :ok
		end
	end

	def add_article
		if (params[:cart_id]==-1)
			cart = Cart.new(:user_id => params[:user_id])
			cart.save
		else
			cart = Cart.find(params[:cart_id])
		end
		if (cart != nil) 
			article = Article.find(params[:article_id])
			if (article != nil)
				cart.add_article(article)
				render json: [{"article_count"=>cart.get_count(article),"cart_id"=>cart.id}], status: :ok
			else
				render json: ["article"], status: :not_found
			end
		else
			render json: ["cart"], status: :not_found
		end
	end

	def remove_article
		if (params[:cart_id]==-1)
			render json: ["cart_id must not be -1"], status: :forbidden
		else
			cart = Cart.find(params[:cart_id])
			if (cart != nil) 
				article = Article.find(params[:article_id])
				if (article != nil)
#					if (cart.change_article_count(article, cart.get_count(article)-1))
#						render json: [{"article_count"=>cart.get_count(article)}], status: :ok
#					else
#						cart.remove_article(article)
#						render json: [{"article_count"=>0}], status: :ok
#					end
					cart.remove_article(article)
					render json: [{"article_count"=>cart.get_count(article)}], status: :ok
				else
					render json: [], status: :not_found
				end
			else
				render json: [], status: :not_found
			end
		end
	end

end