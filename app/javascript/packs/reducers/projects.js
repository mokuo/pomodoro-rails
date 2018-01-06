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
    case 'END_TASK_DELETION': {
      const immutableState = fromJS(state)
      const updatedImmutableState = immutableState.map(project => {
        const index = project.get('tasks').findKey(task => task.get('id') === action.id)
        if (index === undefined) {
          return project
        }
        return project.updateIn(['tasks'], tasks => tasks.delete(index))
      })
      return updatedImmutableState.toJS()
    }
    default:
      return state
  }
}

export default projects
