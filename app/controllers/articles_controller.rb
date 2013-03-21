class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end


  def add_rating
    @article = Article.find(params[:id])
    @rating = Rating.new(:value => params[:value],:user_id => @active_user.id, :rateable_id => @article.id, :rateable_type => "article")
    @rating.save
    @article.ratings << @rating
    @article.save
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Danke fuer die Bewertung"}
      format.json { render json: @rating }
    end
  end

  def add_comment
    @article = Article.find(params[:id])
    @comment = Comment.new(value: params[:value], commentable_type: "article", commentable_id: @article.id, user_id: @active_user.id)
    respond_to do |format|
      if @article.add_comment(@comment)
        format.html { redirect_to root_path, notice: "Danke fuer den Kommentar!"}
        format.json { render json: @comment }
        format.js
      else
        format.html { redirect_to root_path, notice: "Der Kommentar muss zwischen "}
        format.json { render json: @comment.errors }
        format.js
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
