import React from 'react'
import PropTypes from 'prop-types'
import Task from './Task'

const Project = props =>
  (
    <tbody>
      <tr className="table-primary">
        <th colSpan="10">{props.name}</th>
      </tr>
      {props.tasks.map(task => (
        <Task key={task.id} {...task} />
      ))}
    </tbody>
  )

Project.propTypes = {
  name: PropTypes.string.isRequired,
  tasks: PropTypes.arrayOf(PropTypes.object).isRequired
}

export default Project
