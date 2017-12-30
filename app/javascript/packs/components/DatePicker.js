import React from 'react'
import PropTypes from 'prop-types'

const DatePicker = props =>
  (
    <div className="col-sm-2 mb-3">
      <input type="text" className="form-control" id="datetimepicker4" value={props.date} />
    </div>
  )

export default DatePicker
