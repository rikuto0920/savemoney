class ApplicationController < ActionController::Base
# deviseコントローラーにストロングパラメータを追加する          More actions
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :prof])
  end

  # ログイン後のリダイレクト先を変更
  def after_sign_in_path_for(resource)
    students_path  # ログイン後に飛ばしたいパス
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    students_path  # ← トップページに戻す場合
  end
end
