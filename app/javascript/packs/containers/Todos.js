import { connect } from 'react-redux'
import ProjectList from '../components/ProjectList'

const mapStateToProps = state => (
  {
    projects: state.projects
  }
)

const mapDispatchToProps = () => (
  {
    onPlusClick: projectId => {
      console.log(projectId);
    }
  }
)


const Todos = connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectList)

export default Todos
