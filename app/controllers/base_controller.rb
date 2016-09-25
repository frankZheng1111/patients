class BaseController < ApplicationController
  def change_locale
    set_locale
    redirect_to_back
  end
end
