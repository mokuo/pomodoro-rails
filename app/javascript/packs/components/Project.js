import React from 'react'
import PropTypes from 'prop-types'
import Todo from './Todo'
import Activity from './Activity'

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
              if (taskName.trim() !== '') {
                props.createTask(props.id, taskName, props.date)
              }
              props.finishOperation()
            }}
            onKeyPress={e => {
              const taskName = e.target.value
              if (e.key === 'Enter' && taskName.trim() !== '') {
                props.createTask(props.id, taskName, props.date)
                props.finishOperation()
              }
            }}
            autoFocus
          />
        </td>
      </tr>
    )
  }

  const tasks = props.tasks.map(task => {
    switch (location.pathname) {
      case '/todos':
        return (<Todo
          key={task.id}
          {...task}
          operation={props.operation}
          onXClick={props.onXClick}
          onTaskClick={props.onTaskClick}
          finishOperation={props.finishOperation}
          updateTask={props.updateTask}
          onCheck={props.onCheck}
        />)
      case '/activities':
        return (<Activity
          key={task.id}
          {...task}
          operation={props.operation}
          onXClick={props.onXClick}
          onTaskClick={props.onTaskClick}
          finishOperation={props.finishOperation}
          updateTask={props.updateTask}
        />)
      default:
        return null
    }
  })

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
      {tasks}
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
  date: PropTypes.string,
  onPlusClick: PropTypes.func.isRequired,
  createTask: PropTypes.func.isRequired,
  finishOperation: PropTypes.func.isRequired,
  onXClick: PropTypes.func.isRequired,
  onTaskClick: PropTypes.func.isRequired,
  updateTask: PropTypes.func.isRequired,
  onCheck: PropTypes.func.isRequired
}

Project.defaultProps = {
  date: null
}

export default Project
