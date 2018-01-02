const initialState = {
  type: null,
  object: null,
  projectId: null,
  taskId: null,
  pomodoroId: null
}

const operation = (state = initialState, action) => {
  switch (action.type) {
    case 'NEW_TASK':
      return {
        type: 'new',
        object: 'task',
        projectId: action.projectId,
        taskId: null,
        pomodoroId: null
      }
    case 'FINISH_OPERATION':
      return initialState
    default:
      return state
  }
}

export default operation
