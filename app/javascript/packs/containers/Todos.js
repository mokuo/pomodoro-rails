import { connect } from 'react-redux'
import ProjectList from '../components/ProjectList'

const mapStateToProps = state => (
  {
    projects: state.projects
  }
)

const Todos = connect(mapStateToProps)(ProjectList)

export default Todos
