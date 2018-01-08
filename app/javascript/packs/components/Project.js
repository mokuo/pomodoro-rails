import React from 'react'
import PropTypes from 'prop-types'
import Task from './Task'

const Project = props => {
  let newTask = null

  if (
    props.operation.type === 'new' &&
    props.operation.object === 'task' &&
    props.operation.projectId === props.id
  ) {
    newTask = (
      <tr>
        <td className="pl-4" width="10" />
        <td>
          <input
            type="text"
            className="form-control"
            onBlur={e => {
              const taskName = e.target.value
              if (taskName.trim() === '') {
                props.onFinishOperation()
                return
              }
              props.onCreateTask(props.id, taskName, props.date)
            }}
            onKeyPress={e => {
              const taskName = e.target.value
              if (taskName.trim() === '') { return }
              if (e.key === 'Enter') {
                props.onCreateTask(props.id, taskName, props.date)
              }
            }}
            autoFocus
          />
        </td>
      </tr>
    )
  }

  return (
    <tbody>
      <tr className="table-primary">
        <th colSpan="11">
          {props.name}
          <a
            href=""
            className="ml-2"
            onClick={e => {
              e.preventDefault()
              props.onPlusClick(props.id)
            }}
          >
            <span className="oi oi-plus" title="plus" aria-hidden="true" />
          </a>
        </th>
      </tr>
      {props.tasks.map(task => (
        <Task
          key={task.id}
          {...task}
          operation={props.operation}
          onXClick={props.onXClick}
          onTaskClick={props.onTaskClick}
          onFinishOperation={props.onFinishOperation}
          onUpdateTask={props.onUpdateTask}
        />
      ))}
      {newTask}
    </tbody>
  )
}

Project.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  tasks: PropTypes.arrayOf(PropTypes.object).isRequired,
  operation: PropTypes.shape({
    type: PropTypes.string,
    object: PropTypes.string,
    projectId: PropTypes.number
  }).isRequired,
  date: PropTypes.string.isRequired,
  onPlusClick: PropTypes.func.isRequired,
  onCreateTask: PropTypes.func.isRequired,
  onFinishOperation: PropTypes.func.isRequired,
  onXClick: PropTypes.func.isRequired,
  onTaskClick: PropTypes.func.isRequired,
  onUpdateTask: PropTypes.func.isRequired
}

export default Project
