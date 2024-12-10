module CurrentUserHelper
  def set_current_user(user = nil)
    Current.user = user || FactoryBot.create(:user)
  end
end
