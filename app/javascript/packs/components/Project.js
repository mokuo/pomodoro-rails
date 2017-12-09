import React from 'react'
import PropTypes from 'prop-types'

const Project = props =>
  (
    <tr className="table-primary">
      <th colSpan="10">{props.name}</th>
    </tr>
  )

Project.propTypes = {
  name: PropTypes.string.isRequired
}

export default Project
