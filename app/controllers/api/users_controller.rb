class Api::UsersController < ApiController
  def index
    @users = User.all
  end

  def create
    @user = UserService::CreateUser.new(user_params).call
    if @user
      @user
    else
      render json: {
        error: @user.errors,
        message: 'Creating user failed.'
      }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      @user
    else
      render json: {
        error: @user.errors,
        message: 'Updating user failed.'
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      @user
    else
      render json: {
        error: @user.errors,
        message: 'Deleting user failed.'
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user)
    .permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end

end
