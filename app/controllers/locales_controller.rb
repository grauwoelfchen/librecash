class LocalesController < WorkspaceController
  before_action :set_user

  def switch
    @user.skip_password = true
    if @user.update_attributes(locale_params)
      session[:locale] = I18n.locale = locale_params[:locale].intern
    end
    redirect_back_or_to(root_url)
  end

  private

  def set_user
    @user = current_user
  end

  def locale_params
    params.require(:user).permit(:locale)
  end
end
