import React from 'react'
import PropTypes from 'prop-types'
import Pomodoro from './Pomodoro'

const Task = props => {
  const emptyPomodoros = []

  for (let i = 0; i < 8 - props.pomodoros.length; i += 1) {
    emptyPomodoros.push(<Pomodoro key={i} />)
  }

  return (
    <tr>
      <td className="pl-4" width="10"><input type="checkbox" /></td>
      <td>{props.name}</td>
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
  onXClick: PropTypes.func.isRequired
}

export default Task
