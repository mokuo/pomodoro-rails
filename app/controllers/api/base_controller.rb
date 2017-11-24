class Api::BaseController < ActionController::Base
  # TODO: ApplicationController を継承する
  include ApiErrorHandleActions
end
