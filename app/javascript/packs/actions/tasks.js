import axios from 'axios'

export const newTask = projectId => (
  {
    type: 'NEW_TASK',
    projectId
  }
)

const receiveTask = task => (
  {
    type: 'RECEIVE_TASK',
    projectId: task.project_id,
    task: {
      id: task.id,
      name: task.name,
      done: task.done,
      pomodoros: []
    }
  }
)

export const createTask = (projectId, name, todoOn) => (
  dispatch => {
    axios.post(`/api/v1/projects/${projectId}/tasks`, {
      name,
      todo_on: todoOn
    })
      .then(response => {
        dispatch(receiveTask(response.data.task))
      })
  }
)
