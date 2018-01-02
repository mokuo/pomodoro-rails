import { connect } from 'react-redux'
import ProjectList from '../components/ProjectList'
import { newTask, createTask } from '../actions/tasks'
import { finishOperation } from '../actions/operation'

const mapStateToProps = state => (
  {
    projects: state.projects,
    operation: state.operation
  }
)

const mapDispatchToProps = dispatch => (
  {
    onPlusClick: projectId => {
      dispatch(newTask(projectId))
    },
    onCreateTask: (projectId, name) => {
      const todoOn = document.getElementById('date').text
      dispatch(createTask(projectId, name, todoOn))
      dispatch(finishOperation())
    }
  }
)


const Todos = connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectList)

export default Todos
