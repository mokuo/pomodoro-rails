concern :ApiErrorHandleActions do
  included do
    rescue_from ActionController::ParameterMissing do
      render json: { error: { code: 400, message: '実行に必要なパラメーターが送信されていません' } }
    end
  end
end
