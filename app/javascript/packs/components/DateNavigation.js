import React from 'react'
import PropTypes from 'prop-types'

const DateNavigation = props =>
  (
    <div className="mb-2">
      <span className="ml-2 mr-3">{props.date}</span>
      <a className="btn btn-light mr-3" role="button"> today </a>
      <a className="btn btn-outline-light mr-2" role="button"> &lt; </a>
      <a className="btn btn-outline-light mr-2" role="button"> &gt; </a>
    </div>
  )

DateNavigation.propTypes = {
  date: PropTypes.string.isRequired
}

export default DateNavigation
