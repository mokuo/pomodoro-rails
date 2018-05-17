import axios from 'axios'
import handleResponse from './common/handleResponse'
import handleError from './common/handleError'
import { startFetching } from './fetching'

const receiveTodos = projects => (
  {
    type: 'RECEIVE_TODOS',
    projects
  }
)

export const fetchTodos = date => (
  dispatch => {
    dispatch(startFetching())
    axios.get('/api/v1/todos', {
      params: {
        date
      }
    })
      .then(response => {
        const action = receiveTodos(response.data.projects)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
      })
  }
)
