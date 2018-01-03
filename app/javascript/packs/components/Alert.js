import React from 'react'
import PropTypes from 'prop-types'

const Alert = props => {
  let alertDanger = null

  const errorMessages = props.error.messages.map(msg => <p className="mb-0">{msg}</p>)

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

Alert.propTypes = {
  error: PropTypes.shape({
    code: PropTypes.number.isRequired,
    messages: PropTypes.array.isRquired
  }).isRequired
}

export default Alert
