class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :restrict, only: [:edit, :update, :destroy]


  def restrict
    render nothing: true if @user != current_user and @user.can_write?
  end

  def sign_in
    if params[:user]
      if params[:commit] == 'Sign in'
        if user = User.where(user_params).first
          successfully_enter user
        else
          flash[:error] = 'Either incorrect login or password'
        end
      else
        user = User.create_by_attr_and_role(user_params[:login], user_params[:password], 'user')
        if user.errors.any?
          flash[:error] = user.errors
        else
          successfully_enter user, 'up'
        end
      end
    end
  end

  def sign_out
    reset_session
    redirect_to root_url
  end
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @user.role = Role.find(params[:role][:id]) if current_user.can_write?
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def successfully_enter user, action = 'in'
      session[:user_id] = user.id
      flash[:success] = "Signed #{action} successfully"
      redirect_to users_path
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:login, :password)
    end
end
