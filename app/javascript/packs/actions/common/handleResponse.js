import { receiveError } from '../error'

const handleResponse = (dispatch, response, action) => {
  const responseStatus = response.status

  if (responseStatus === 500) {
    const serverError = {
      error: {
        code: responseStatus,
        messages: ['サーバーエラーが発生しました', '時間を置いて再度アクセスしてください']
      }
    }
    receiveError(serverError)
    return
  }

  if (responseStatus !== 200) {
    const unexpectedError = {
      error: {
        code: responseStatus,
        messages: ['非同期通信で予期せぬエラーが発生しました']
      }
    }
    receiveError(unexpectedError)
    return
  }

  const { error } = response.data
  if (error.code === 0) {
    dispatch(action)
  } else {
    dispatch(receiveError(error))
  }
}

export default handleResponse
