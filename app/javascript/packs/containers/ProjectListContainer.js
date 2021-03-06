import { connect } from 'react-redux'
import ProjectList from '../components/ProjectList'
import { newTask, createTask, editTask, updateTask, toggleTask, moveTask } from '../actions/tasks'
import { finishOperation } from '../actions/operation'
import { openDeleteTaskModal } from '../actions/modals'

const mapStateToProps = state => (
  {
    projects: state.projects.toJS(),
    operation: state.operation.toJS(),
    date: state.date,
    sheet: state.sheet
  }
)

const mapDispatchToProps = dispatch => (
  {
    onPlusClick: projectId => {
      dispatch(newTask(projectId))
    },
    createTask: (projectId, name, todoOn) => {
      dispatch(createTask(projectId, name, todoOn))
    },
    finishOperation: () => {
      dispatch(finishOperation())
    },
    onXClick: (taskId, taskName) => {
      dispatch(openDeleteTaskModal(taskId, taskName))
    },
    onTaskClick: id => {
      dispatch(editTask(id))
    },
    updateTask: (id, name) => {
      dispatch(updateTask(id, name))
    },
    onCheck: id => {
      dispatch(toggleTask(id))
    },
    moveTask: id => {
      dispatch(moveTask(id))
    }
  }
)


const ProjectListContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectList)

export default ProjectListContainer
