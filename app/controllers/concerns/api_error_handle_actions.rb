concern :ApiErrorHandleActions do
  included do
    rescue_from ActionController::ParameterMissing do
      render_json(400, '実行に必要なパラメーターが送信されていません')
    end

    rescue_from ActiveRecord::RecordNotFound do
      render_json(401, '指定されたリソースが見つかりません')
    end
  end

  private

  def render_json(code, message)
    render json: { error: { code: code, message: message } }
  end
end
