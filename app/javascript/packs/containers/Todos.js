import { connect } from 'react-redux'
import ProjectList from '../components/ProjectList'
import { newTask, createTask } from '../actions/tasks'
import { finishOperation } from '../actions/operation'
import { openDeleteTaskModal } from '../actions/modals'

const mapStateToProps = state => (
  {
    projects: state.projects,
    operation: state.operation,
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
      dispatch(finishOperation())
    },
    onFinishOperation: () => dispatch(finishOperation()),
    onXClick: (taskId, taskName) => {
      dispatch(openDeleteTaskModal(taskId, taskName))
    }
  }
)


const Todos = connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectList)

export default Todos
