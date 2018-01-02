import React from 'react'
import PropTypes from 'prop-types'
import Project from './Project'

const ProjectList = props =>
  (
    <table className="table table">
      {props.projects.map(project => (
        <Project
          key={project.id}
          onPlusClick={() => props.onPlusClick(project.id)}
          {...project}
          operation={props.operation}
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
  }).isRequired
}

export default ProjectList
