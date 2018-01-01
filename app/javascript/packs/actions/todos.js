import axios from 'axios'

const receiveTodos = projects => (
  {
    type: 'RECEIVE_TODOS',
    projects
  }
)

export const fetchTodos = date => (
  dispatch => {
    axios.get('/api/v1/todos', {
      params: {
        date
      }
    })
      .then(response => {
        dispatch(receiveTodos(response.data.projects))
      })
  }
)