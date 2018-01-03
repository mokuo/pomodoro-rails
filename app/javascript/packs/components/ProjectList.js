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
          onPlusClick={props.onPlusClick}
          onCreateTask={props.onCreateTask}
          onFinishOperation={props.onFinishOperation}
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
  date: PropTypes.string.isRequired,
  onPlusClick: PropTypes.func.isRequired,
  onCreateTask: PropTypes.func.isRequired,
  onFinishOperation: PropTypes.func.isRequired
}

export default ProjectList
