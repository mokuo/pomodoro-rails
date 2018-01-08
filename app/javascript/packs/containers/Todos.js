import { connect } from 'react-redux'
import ProjectList from '../components/ProjectList'
import { newTask, createTask, editTask, updateTask } from '../actions/tasks'
import { finishOperation } from '../actions/operation'
import { openDeleteTaskModal } from '../actions/modals'

const mapStateToProps = state => (
  {
    projects: state.projects.toJS(),
    operation: state.operation.toJS(),
    date: state.date
  }
)

const mapDispatchToProps = dispatch => (
  {
    onPlusClick: projectId => {
      dispatch(newTask(projectId))
    },
    onCreateTask: (projectId, name, todoOn) => {
      dispatch(createTask(projectId, name, todoOn))
    },
    onFinishOperation: () => dispatch(finishOperation()),
    onXClick: (taskId, taskName) => {
      dispatch(openDeleteTaskModal(taskId, taskName))
    },
    onTaskClick: id => {
      dispatch(editTask(id))
    },
    onUpdateTask: (id, name) => {
      dispatch(updateTask(id, name))
    }
  }
)


const Todos = connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectList)

export default Todos
