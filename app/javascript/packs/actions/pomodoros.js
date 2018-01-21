import axios from 'axios'
import { receiveError } from './error'

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
        const { error } = response.data
        dispatch(receiveError(error))
        if (error.code === 0) {
          dispatch(receivePomodoro(response.data.pomodoro))
        }
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
        const { error } = response.data
        dispatch(receiveError(error))
        if (error.code === 0) {
          dispatch(finishPomodoroUpdate(response.data.pomodoro))
        }
      })
  }
)
