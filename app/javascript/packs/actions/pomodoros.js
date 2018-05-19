import axios from 'axios'
import handleResponse from './common/handleResponse'
import handleError from './common/handleError'
import { startFetching } from './fetching'

const receivePomodoro = pomodoro => (
  {
    type: 'RECEIVE_POMODORO',
    taskId: pomodoro.task_id,
    pomodoro
  }
)

export const createPomodoro = (taskId, box) => (
  dispatch => {
    dispatch(startFetching())
    axios.post(`/api/v1/tasks/${taskId}/pomodoros`, { box })
      .then(response => {
        const action = receivePomodoro(response.data.pomodoro)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
      })
  }
)

const finishPomodoroUpdate = pomodoro => (
  {
    type: 'FINISH_POMODORO_UPDATE',
    pomodoro
  }
)

export const updatePomodoro = (id, box) => (
  dispatch => {
    dispatch(startFetching())
    axios.patch(`/api/v1/pomodoros/${id}`, { box })
      .then(response => {
        const action = finishPomodoroUpdate(response.data.pomodoro)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
      })
  }
)

export const togglePomodoro = (id, done) => (
  dispatch => {
    dispatch(startFetching())
    axios.patch(`/api/v1/pomodoros/${id}`, { done })
      .then(response => {
        const action = finishPomodoroUpdate(response.data.pomodoro)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
      })
  }
)

const finishPomodoroDeletion = id => (
  {
    type: 'FINISH_POMODORO_DELETION',
    id
  }
)

export const deletePomodoro = id => (
  dispatch => {
    dispatch(startFetching())
    axios.delete(`/api/v1/pomodoros/${id}`)
      .then(response => {
        const action = finishPomodoroDeletion(id)
        handleResponse(dispatch, response, action)
      })
      .catch(error => {
        handleError(dispatch, error)
      })
  }
)
