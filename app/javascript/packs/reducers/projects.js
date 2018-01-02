import { fromJS } from 'immutable'

const projects = (state = window.projects, action) => {
  switch (action.type) {
    case 'RECEIVE_TODOS':
      return action.projects
    case 'RECEIVE_TASK': {
      const immutableState = fromJS(state)
      const updatedImmutableState = immutableState.map(project => {
        if (project.get('id') === action.projectId) {
          return project.updateIn(['tasks'], tasks => tasks.push(action.task))
        }
        return project
      })
      return updatedImmutableState.toJS()
    }
    default:
      return state
  }
}

export default projects
