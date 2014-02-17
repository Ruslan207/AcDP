class Admin::UsersController < ApplicationController
  authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    @searchType = params[:searchType]
    @searchStr = params[:searchStr]
    @searchTypeStr = ''
    page = params[:page]

    if @searchType.nil?
      @users = User.page page
      @searchType = '1'
      @searchStr = ''
      @searchTypeStr = t('activerecord.attributes.user.login')
    elsif @searchType === '1'
      @users = Kaminari.paginate_array(User.where(User.arel_table[:login].matches('%' + @searchStr + '%'))).page(page)
      @searchTypeStr = t('activerecord.attributes.user.login')
    elsif @searchType === '2'
      @users = Kaminari.paginate_array(User.where(User.arel_table[:email].matches('%' + @searchStr + '%'))).page(page)
      @searchTypeStr = t('activerecord.attributes.user.email')
    elsif @searchType === '3'
      @users = Kaminari.paginate_array(User.where(User.arel_table[:full_name].matches('%' + @searchStr + '%'))).page(page)
      @searchTypeStr = t('activerecord.attributes.user.full_name')
    end
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to [:admin, @user], notice: t('users.notice.created')
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @user.update(user_params)
      redirect_to [:admin, @user], notice: t('users.notice.updated')
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user)
      .permit(:login, :password, :password_confirmation, :role, :email, :full_name)
      .delete_if {|k, v| k =~ /password/ && v.blank?}
  end
end
