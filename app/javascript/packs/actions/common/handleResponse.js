import { receiveError } from '../error'
import { finishFetching } from '../fetching'

const handleResponse = (dispatch, response, action) => {
  const { error } = response.data
  dispatch(receiveError(error)) // エラーコード 0 の場合はアラートを非表示にする
  if (error.code === 0) {
    dispatch(action)
  }
  dispatch(finishFetching())
}

export default handleResponse
