import React from 'react'
import PropTypes from 'prop-types'
import Task from './Task'

const Project = props => {
  let newTask = null
  if (props.operation.type === 'new' && props.operation.object === 'task' && props.operation.projectId === props.id) {
    newTask = (
      <tr>
        <td className="pl-4" width="10" />
        <td><input type="text" className="form-control" /></td>
      </tr>
    )
  }

  return (
    <tbody>
      <tr className="table-primary">
        <th colSpan="10">
          {props.name}
          <a
            href=""
            className="ml-2"
            onClick={e => {
              e.preventDefault()
              props.onPlusClick()
            }}
          >
            <span className="oi oi-plus" title="plus" aria-hidden="true" />
          </a>
        </th>
      </tr>
      {props.tasks.map(task => (
        <Task key={task.id} {...task} />
      ))}
      {newTask}
    </tbody>
  )
}

Project.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  tasks: PropTypes.arrayOf(PropTypes.object).isRequired,
  onPlusClick: PropTypes.func.isRequired,
  operation: PropTypes.shape({
    type: PropTypes.string,
    object: PropTypes.string,
    projectId: PropTypes.number
  }).isRequired
}

export default Project
