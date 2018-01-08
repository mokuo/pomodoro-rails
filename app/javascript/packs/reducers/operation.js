import { Map } from 'immutable'

const initialState = Map({
  type: null,
  object: null,
  projectId: null,
  taskId: null,
  pomodoroId: null
})

const operation = (state = initialState, action) => {
  switch (action.type) {
    case 'NEW_TASK':
      return state.merge({
        type: 'new',
        object: 'task',
        projectId: action.projectId
      })
    case 'EDIT_TASK':
      return state.merge({
        type: 'edit',
        object: 'task',
        taskId: action.id
      })
    case 'FINISH_OPERATION':
      return initialState
    default:
      return state
  }
}

export default operation
