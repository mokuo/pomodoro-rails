import React from 'react'
import PropTypes from 'prop-types'
import Pomodoro from './Pomodoro'

const Task = props => {
  let task = (
    <td onClick={() => props.onTaskClick(props.id)}>
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

  const emptyPomodoros = []
  for (let i = 0; i < 8 - props.pomodoros.length; i += 1) {
    emptyPomodoros.push(<Pomodoro key={i} />)
  }

  return (
    <tr>
      <td className="pl-4" width="10">
        <input
          type="checkbox"
          onChange={() => props.onCheck(props.id, !props.done)}
          checked={props.done}
        />
      </td>
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
  done: PropTypes.bool.isRequired,
  pomodoros: PropTypes.arrayOf(PropTypes.object).isRequired,
  operation: PropTypes.shape({
    type: PropTypes.string,
    object: PropTypes.string,
    taskId: PropTypes.number
  }).isRequired,
  onXClick: PropTypes.func.isRequired,
  onTaskClick: PropTypes.func.isRequired,
  finishOperation: PropTypes.func.isRequired,
  updateTask: PropTypes.func.isRequired,
  onCheck: PropTypes.func.isRequired
}

export default Task
