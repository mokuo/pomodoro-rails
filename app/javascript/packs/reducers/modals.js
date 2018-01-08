import { fromJS } from 'immutable'

const initialState = fromJS({
  deleteTaskModal: {
    isOpen: false,
    taskId: null,
    taskName: null
  }
})

const modals = (state = initialState, action) => {
  switch (action.type) {
    case 'OPEN_DELETE_TASK_MODAL':
      return state.mergeDeep({
        deleteTaskModal: {
          isOpen: true,
          taskId: action.taskId,
          taskName: action.taskName
        }
      })
    case 'CLOSE_MODAL':
      return initialState
    default:
      return state
  }
}

export default modals
