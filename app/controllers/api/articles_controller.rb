class Api::ArticlesController < ApiController

  # GET /Users/:User_id/articles
  def index
    @articles = Article.where(user_id: params[:user_id])
  end

  # POST /Users/:User_id/articles
  def create
    @article = Article.new(article_params)
    #@article.user_id = params[:user_id]
    if @article.save
      @article
    else
      render json: {
        error: @article.errors,
        message: 'Creating article failed.'
      }, status: :unprocessable_entity
    end
  end

  # PUT /Users/:User_id/articles/:id
  def update
    if @article.update(article_params)
      @article
    else
      render json: {
        error: @article.errors,
        message: 'Updating article failed.'
      }, status: :unprocessable_entity
    end
  end

  # DELETE /Users/:User_id/articles/:id
  def destroy
    if @article.destroy
      @article
    else
      render json: {
        error: @article.errors,
        message: 'Deleting article failed.'
      }, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article)
    .permit(:title, :tagline, :body, :user_id)
  end
end
