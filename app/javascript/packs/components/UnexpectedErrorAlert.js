import React from 'react'
import PropTypes from 'prop-types'
import { Alert } from 'reactstrap'

const UnexpectedErrorAlert = props =>
  (
    <div>
      <Alert color="danger" isOpen={props.isOpen} toggle={props.onDismiss}>
        <h4 className="alert-heading">予期せぬエラーが発生しました。</h4>
        <p>
          時間を置いて再度お試しください。
        </p>
        <hr />
        <p className="mb-0">
          {props.errorMessage}
        </p>
      </Alert>
    </div>
  )

UnexpectedErrorAlert.propTypes = {
  errorMessage: PropTypes.string.isRequired,
  isOpen: PropTypes.bool.isRequired,
  onDismiss: PropTypes.func.isRequired
}

export default UnexpectedErrorAlert
