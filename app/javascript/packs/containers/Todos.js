import { connect } from 'react-redux'
import ProjectList from '../components/ProjectList'
import { newTask } from '../actions/tasks'

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
    }
  }
)


const Todos = connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectList)

export default Todos
