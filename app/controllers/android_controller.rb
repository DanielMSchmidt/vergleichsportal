class AndroidController < ApplicationController

	def default_serializer_options
		{root: false}
	end

	########## UsersAPIController methods ##########

	# used for login with username and password as POST request
	# returns status codes which will be mapped by the app to concrete error messages
	def check_auth
		if @user = login(params[:username],params[:password])
			if (!@user.active)
				render :json => [], :status => :forbidden
			else 
				render :json => ["userid" => @user.id], :status => :accepted
			end
		else
			@user = User.find_by_email(params[:username])
			if (@user != nil)
				# activation state was removed from our domain but may come back
				#if (@user.activation_state != "active")
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
		@user = User.find_by_email(params[:user][:email])
		if (@user != nil)
			render :json => [], :status => :conflict
		else
			@user_new = User.new(params[:user])
    		@user_new.role_id = 1
    		if @user_new.save
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
		@providers = Provider.where(active: true)
		#@providers = Provider.all;
		if (@providers != nil)
			render json: @providers, each_serializer: ProviderForAndroidSerializer, status: :ok
		else
			render json: [], status: :ok
		end
	end

	# used to save a made rating for a provider as POST request
	# returns status codes which symbols success or failure of giving the rating (must be interpreted by the app)
	def rate_provider
		@provider = Provider.find(params[:provider_id])
		if (@provider != nil)
			@rating = Rating.new(:value => params[:rating],:user_id => params[:user_id], :provider_id => @provider.id)
			@rating.save
		    @provider.ratings << @rating
		    @provider.save
		    render json: ["rating" => @provider.average_rating, "ratecount" => @provider.ratings.size], status: :accepted
		else
			render json: [], status: :not_found
		end
	end

	######## ArticleAPIController methods ##########

	def debug
		@search = Search.new("illuminati")
	    @result = @search.find.reject{|result| result == false || result.id.nil?}.uniq # TODO: Check where nils come from (see home#search_results)
	    render json: @result, each_serializer: ArticleForAndroidSerializer, status: :ok
	end

	def search
	    search = Search.new(params[:options][:title])
	    @result = search.find.reject{|result| result == false || result.id.nil?}.uniq # TODO: Check where nils come from (see home#search_results)
	    render json: @result, each_serializer: ArticleForAndroidSerializer, status: :ok
	end

	# used to save a made rating for an article as POST request
	# returns status codes which symbols success or failure of giving the rating (must be interpreted by the app)
	def rate_article
		@article = Article.find(params[:article_id])
		if (@article != nil)
		    @rating = Rating.new(:value => params[:rating],:user_id => params[:user_id], :rateable_id => @article.id, :rateable_type => "article")
		    @rating.save
		    @article.ratings << @rating
		    @article.save
		    render json: ["rating" => @article.average_rating, "ratecount" => @article.ratings.size], status: :accepted
		else
			render json: [], status: :not_found
		end
	end

	# used to save a made comment for an article as POST request
	# returns status codes which symbols success or failure of giving the comment (must be interpreted by the app)
	def comment_article
		@article = Article.find(params[:article_id])
		if (@article != nil)
		    @comment = Comment.new(:value => params[:comment],:user_id => params[:user_id], :commentable_id => @article.id, :commentable_type => "article")
		    @article.add_comment(@comment)
		    render json: [], status: :accepted
		else
			render json: [], status: :not_found
		end
	end

	def article_comments
		@comments = Comment.where(commentable_id: params[:article_id], commentable_type: "Article")
		if (@comments != nil)
			render json: @comments, each_serializer: ArticleCommentForAndroidSerializer, status: :ok
		else
			render json: [], status: :ok
		end
	end

	######## CartAPIController methods ##########

	def all_carts
		@carts = Cart.where(user_id: params[:user_id])
		if (@carts != nil)
			render json: @carts, each_serializer: CartForAndroidSerializer, status: :ok
		else
			render json: [], status: :ok
		end
	end

end