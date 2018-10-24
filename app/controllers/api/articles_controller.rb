class ArticlesController < ApiController
  before_action :set_user
  before_action :set_user_article, only: [:update, :destroy]

  # GET /Users/:User_id/articles
  def index
    @articles = Article.all
  end

  # POST /Users/:User_id/articles
  def create
    if @user.articles.create!(article_params)
      @user.article
    else
      render json: {
        error: @user.article.errors,
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
    .permit(:title, :tagline, :body)
  end

  def set_user
    @user = User.find(params[:User_id])
  end

  def set_user_article
    @article = @user.articles.find_by!(id: params[:id]) if @user
  end
end
