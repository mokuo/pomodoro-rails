import React from 'react'
import PropTypes from 'prop-types'

const symbol = box => {
  switch (box) {
    case 'square':
      return '□'
    case 'circle':
      return '○'
    case 'triangle':
      return '△'
    default:
      return ''
  }
}

const Pomodoro = props =>
  (
    <td className="pomodoro-box text-center" width="48">{symbol(props.box)}</td>
  )

Pomodoro.propTypes = {
  box: PropTypes.string
}

Pomodoro.defaultProps = {
  box: ''
}

export default Pomodoro
