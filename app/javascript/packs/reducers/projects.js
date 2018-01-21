import { fromJS } from 'immutable'

const projects = (state = fromJS(window.projects), action) => {
  switch (action.type) {
    case 'RECEIVE_TODOS':
      return fromJS(action.projects)
    case 'RECEIVE_TASK': {
      const index = state.findKey(project => project.get('id') === action.projectId)
      return state.updateIn([index, 'tasks'], tasks => tasks.push(fromJS(action.task)))
    }
    case 'FINISH_TASK_DELETION': {
      return state.map(project => {
        const index = project.get('tasks').findKey(task => task.get('id') === action.id)
        if (index === undefined) {
          return project
        }
        return project.updateIn(['tasks'], tasks => tasks.delete(index))
      })
    }
    case 'FINISH_TASK_UPDATE': {
      return state.map(project => {
        const index = project.get('tasks').findKey(task => task.get('id') === action.id)
        if (index === undefined) {
          return project
        }
        return project.updateIn(['tasks'], tasks => tasks.updateIn([index], task => task.set('name', action.name)))
      })
    }
    case 'FINISH_TASK_TOGGLE': {
      return state.map(project => {
        const index = project.get('tasks').findKey(task => task.get('id') === action.id)
        if (index === undefined) {
          return project
        }
        return project.updateIn(['tasks'], tasks => tasks.updateIn([index], task => task.set('done', action.done)))
      })
    }
    case 'RECEIVE_POMODORO': {
      return state.map(project => {
        const taskIndex = project.get('tasks').findKey(task => task.get('id') === action.taskId)
        if (taskIndex === undefined) {
          return project
        }
        return project.updateIn(['tasks'], tasks => tasks.updateIn([taskIndex, 'pomodoros'], pomodoros => pomodoros.push(fromJS(action.pomodoro))))
      })
    }
    default:
      return state
  }
}

export default projects
