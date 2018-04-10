import axios from 'axios'
import handleResponse from './common/handleResponse'

const receivePomodoro = pomodoro => (
  {
    type: 'RECEIVE_POMODORO',
    taskId: pomodoro.task_id,
    pomodoro
  }
)

export const createPomodoro = (taskId, box) => (
  dispatch => {
    axios.post(`/api/v1/tasks/${taskId}/pomodoros`, { box })
      .then(response => {
        const action = receivePomodoro(response.data.pomodoro)
        handleResponse(dispatch, response, action)
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
    axios.patch(`/api/v1/pomodoros/${id}`, { box })
      .then(response => {
        const action = finishPomodoroUpdate(response.data.pomodoro)
        handleResponse(dispatch, response, action)
      })
  }
)

export const togglePomodoro = (id, done) => (
  dispatch => {
    axios.patch(`/api/v1/pomodoros/${id}`, { done })
      .then(response => {
        const action = finishPomodoroUpdate(response.data.pomodoro)
        handleResponse(dispatch, response, action)
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
    axios.delete(`/api/v1/pomodoros/${id}`)
      .then(response => {
        const action = finishPomodoroDeletion(id)
        handleResponse(dispatch, response, action)
      })
  }
)
