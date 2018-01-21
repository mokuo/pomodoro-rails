import axios from 'axios'
import { receiveError } from './error'

const receivePomodoro = pomodoro => (
  {
    type: 'RECEIVE_POMODORO',
    taskId: pomodoro.task_id,
    pomodoro: {
      id: pomodoro.id,
      box: pomodoro.box,
      done: pomodoro.done
    }
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
