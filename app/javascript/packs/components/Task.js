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
    </tr>
  )
}

Task.propTypes = {
  name: PropTypes.string.isRequired,
  pomodoros: PropTypes.arrayOf(PropTypes.object).isRequired
}

export default Task
