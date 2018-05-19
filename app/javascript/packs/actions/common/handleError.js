import { receiveUnexpectedError } from '../unexpectedError'
import { finishFetching } from '../fetching'

const handleError = (dispatch, error) => {
  dispatch(receiveUnexpectedError(error.message))
  dispatch(finishFetching())
}

export default handleError
