import React from 'react'
import PropTypes from 'prop-types'

const ErrorAlert = props => {
  let alertDanger = null

  const errorMessages = props.error.messages.map((msg, index) => (
    <p key={index} className="mb-0">{msg}</p>
  ))

  if (props.error.code !== 0) {
    alertDanger = (
      <div className="alert alert-danger" role="alert">
        <p className="mb-0">エラーコード : {props.error.code}</p>
        {errorMessages}
      </div>
    )
  }

  return alertDanger
}

ErrorAlert.propTypes = {
  error: PropTypes.shape({
    code: PropTypes.number.isRequired,
    messages: PropTypes.array.isRquired
  }).isRequired
}

export default ErrorAlert
