import React from 'react'
import PropTypes from 'prop-types'

const Alert = props => {
  let alertDanger = null

  const errorMessages = props.error.messages.map(msg => <span>{msg}<br /></span>)

  if (props.error.code !== 0) {
    alertDanger = (
      <div className="alert alert-danger" role="alert">
        <span>エラーコード : {props.error.code}<br /></span>
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
