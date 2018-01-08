import React from 'react'
import PropTypes from 'prop-types'
import Pomodoro from './Pomodoro'

const Task = props => {
  let task = (<td onClick={() => props.onTaskClick(props.id)}>{props.name}</td>)
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
              props.onUpdateTask(props.id, taskName)
            }
            props.onFinishOperation()
          }}
          onKeyPress={e => {
            const taskName = e.target.value
            if (e.key === 'Enter' && taskName.trim() !== '') {
              props.onUpdateTask(props.id, taskName)
              props.onFinishOperation()
            }
          }}
          autoFocus
        />
      </td>
    )
  }

  const emptyPomodoros = []
  for (let i = 0; i < 8 - props.pomodoros.length; i += 1) {
    emptyPomodoros.push(<Pomodoro key={i} />)
  }

  return (
    <tr>
      <td className="pl-4" width="10"><input type="checkbox" /></td>
      {task}
      {props.pomodoros.map(pomodoro => (
        <Pomodoro key={pomodoro.id} {...pomodoro} />
      ))}
      {emptyPomodoros}
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

Task.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  pomodoros: PropTypes.arrayOf(PropTypes.object).isRequired,
  operation: PropTypes.shape({
    type: PropTypes.string,
    object: PropTypes.string,
    taskId: PropTypes.number
  }).isRequired,
  onXClick: PropTypes.func.isRequired,
  onTaskClick: PropTypes.func.isRequired,
  onFinishOperation: PropTypes.func.isRequired,
  onUpdateTask: PropTypes.func.isRequired
}

export default Task
