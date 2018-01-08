import axios from 'axios'
import { receiveError } from './error'

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
        const { error } = response.data
        dispatch(receiveError(error))
        if (error.code === 0) {
          dispatch(receiveTask(response.data.task))
        }
      })
  }
)

const finishTaskDeletion = id => (
  {
    type: 'FINISH_TASK_DELETION',
    id
  }
)

export const deleteTask = id => (
  dispatch => {
    axios.delete(`/api/v1/tasks/${id}`)
      .then(response => {
        const { error } = response.data
        dispatch(receiveError(error))
        if (error.code === 0) {
          dispatch(finishTaskDeletion(id))
        }
      })
  }
)

export const editTask = id => (
  {
    type: 'EDIT_TASK',
    id
  }
)

const finishTaskUpdate = (id, name) => (
  {
    type: 'FINISH_TASK_UPDATE',
    id,
    name
  }
)

export const updateTask = (id, name) => (
  dispatch => {
    axios.patch(`/api/v1/tasks/${id}`, {
      name
    })
      .then(response => {
        const { error } = response.data
        dispatch(receiveError(error))
        if (error.code === 0) {
          dispatch(finishTaskUpdate(id, name))
        }
      })
  }
)
