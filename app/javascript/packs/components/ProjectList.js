import React from 'react'
import PropTypes from 'prop-types'
import Project from './Project'

const ProjectList = props =>
  (
    <table className="table table">
      {props.projects.map(project => (
        <Project
          key={project.id}
          {...project}
          operation={props.operation}
          date={props.date}
          sheet={props.sheet}
          onPlusClick={props.onPlusClick}
          createTask={props.createTask}
          finishOperation={props.finishOperation}
          onXClick={props.onXClick}
          onTaskClick={props.onTaskClick}
          updateTask={props.updateTask}
          onCheck={props.onCheck}
          moveTask={props.moveTask}
        />
      ))}
    </table>
  )

ProjectList.propTypes = {
  projects: PropTypes.arrayOf(PropTypes.object).isRequired,
  operation: PropTypes.shape({
    type: PropTypes.string,
    object: PropTypes.string,
    projectId: PropTypes.number,
    taskId: PropTypes.number,
    pomodoroId: PropTypes.number
  }).isRequired,
  date: PropTypes.string,
  sheet: PropTypes.string.isRequired,
  onPlusClick: PropTypes.func.isRequired,
  createTask: PropTypes.func.isRequired,
  finishOperation: PropTypes.func.isRequired,
  onXClick: PropTypes.func.isRequired,
  onTaskClick: PropTypes.func.isRequired,
  updateTask: PropTypes.func.isRequired,
  onCheck: PropTypes.func.isRequired,
  moveTask: PropTypes.func.isRequired
}

ProjectList.defaultProps = {
  date: null
}

export default ProjectList
