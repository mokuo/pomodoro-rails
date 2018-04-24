import { receiveError } from '../error'

const handleResponse = (dispatch, response, action) => {
  const { error } = response.data
  dispatch(receiveError(error)) // エラーコード 0 の場合はアラートを非表示にする
  if (error.code === 0) {
    dispatch(action)
  }
}

export default handleResponse
