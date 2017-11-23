concern :ApiErrorHandleActions do
  included do
    rescue_from ActionController::ParameterMissing do
      render_json(400, ['実行に必要なパラメーターが送信されていません'])
    end

    rescue_from ActiveRecord::RecordNotFound do
      render_json(401, ['指定されたリソースが見つかりません'])
    end

    # NOTE: 402はバリデーションエラーで使用

    rescue_from ArgumentError do
      render_json(403, ['引数が間違っています'])
    end
  end

  private

  def render_json(code, messages)
    render json: { error: { code: code, messages: messages } }
  end
end
