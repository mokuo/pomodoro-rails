import React from 'react'
import PropTypes from 'prop-types'
import Project from './Project'

const ProjectList = props =>
  (
    <table className="table table">
      <tbody>
        {props.projects.map(project => (
          <Project key={project.id} {...project} />
        ))}
      </tbody>
    </table>
  )

ProjectList.propTypes = {
  projects: PropTypes.arrayOf(PropTypes.object).isRequired
}

export default ProjectList
