# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :ensure_normal_user, only: :destroy
    # before_action :configure_sign_in_params, only: [:create]

    def guest_sign_in
      user = User.guest
      sign_in user
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    end

    def ensure_normal_user
      if resource.email == 'guest@example.com'
        redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
        return
      end
    end

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
