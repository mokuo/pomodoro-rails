import React from 'react'
import PropTypes from 'prop-types'

const Task = props =>
  (
    <tr>
      <td className="pl-4" width="10"><input type="checkbox" /></td>
      <td>{props.name}</td>
    </tr>
  )

Task.propTypes = {
  name: PropTypes.string.isRequired
}

export default Task
