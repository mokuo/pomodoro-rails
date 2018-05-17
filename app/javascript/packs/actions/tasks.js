import axios from 'axios'
import handleResponse from './common/handleResponse'
import handleError from './common/handleError'
import { startFetching } from './fetching'

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
    dispatch(startFetching())
    axios.post(`/api/v1/projects/${projectId}/tasks`, {
      name,
      todo_on: todoOn
    })
      .then(response => {
        const action = receiveTask(response.data.task)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
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
    dispatch(startFetching())
    axios.delete(`/api/v1/tasks/${id}`)
      .then(response => {
        const action = finishTaskDeletion(id)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
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
    dispatch(startFetching())
    axios.patch(`/api/v1/tasks/${id}`, {
      name
    })
      .then(response => {
        const action = finishTaskUpdate(id, name)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
      })
  }
)

const finishTaskToggle = (id, done) => (
  {
    type: 'FINISH_TASK_TOGGLE',
    id,
    done
  }
)

export const toggleTask = id => (
  (dispatch, getState) => {
    let done = null
    getState().projects.forEach(project => {
      const tasks = project.get('tasks')
      const index = tasks.findKey(task => task.get('id') === id)
      if (index !== undefined) {
        done = !tasks.getIn([index, 'done'])
      }
    })

    dispatch(startFetching())
    axios.patch(`/api/v1/tasks/${id}`, {
      done
    })
      .then(response => {
        const action = finishTaskToggle(id, done)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
      })
  }
)

const finishTaskMovement = id => (
  {
    type: 'FINISH_TASK_MOVEMENT',
    id
  }
)

export const moveTask = id => (
  (dispatch, getState) => {
    let todoOn
    switch (getState().sheet) {
      case 'todo':
        todoOn = null
        break
      case 'activity':
        todoOn = getState().date
        break
      default:
        // TODO: アラートを画面に表示する
        console.log('予期せぬエラーが発生しました');
    }

    dispatch(startFetching())
    axios.patch(`/api/v1/tasks/${id}`, {
      todo_on: todoOn
    })
      .then(response => {
        const action = finishTaskMovement(id)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
      })
  }
)
