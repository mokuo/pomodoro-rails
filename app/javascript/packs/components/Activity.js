import React from 'react'
import PropTypes from 'prop-types'

const Activity = props => {
  let task = (
    <td className="clickable" onClick={() => props.onTaskClick(props.id)}>
      <span className={props.done ? 'line-through' : ''}>{props.name}</span>
    </td>
  )
  if (
    props.operation.type === 'edit' &&
    props.operation.object === 'task' &&
    props.operation.taskId === props.id
  ) {
    task = (
      <td>
        <input
          type="text"
          className="form-control"
          defaultValue={props.name}
          onBlur={e => {
            const taskName = e.target.value
            if (taskName.trim() !== '') {
              props.updateTask(props.id, taskName)
            }
            props.finishOperation()
          }}
          onKeyPress={e => {
            const taskName = e.target.value
            if (e.key === 'Enter' && taskName.trim() !== '') {
              props.updateTask(props.id, taskName)
              props.finishOperation()
            }
          }}
          autoFocus
        />
      </td>
    )
  }

  return (
    <tr>
      <td className="pl-4" width="10">
        <input
          type="checkbox"
          onChange={() => props.onCheck(props.id)}
          checked={props.done}
        />
      </td>
      {task}
      <td width="41">
        <a
          href=""
          onClick={e => {
            e.preventDefault()
            props.onXClick(props.id, props.name)
          }}
        >
          <span className="oi oi-x" title="x" aria-hidden="true" />
        </a>
      </td>
    </tr>
  )
}

Activity.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  done: PropTypes.bool.isRequired,
  operation: PropTypes.shape({
    type: PropTypes.string,
    object: PropTypes.string,
    taskId: PropTypes.number
  }).isRequired,
  onXClick: PropTypes.func.isRequired,
  onTaskClick: PropTypes.func.isRequired,
  finishOperation: PropTypes.func.isRequired,
  updateTask: PropTypes.func.isRequired
}

export default Activity
