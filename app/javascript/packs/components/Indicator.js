import React from 'react'
import PropTypes from 'prop-types'
import Spinner from 'react-activity/lib/Spinner'

const Indicator = props => (props.fetching ? <Spinner size={24} /> : null)

Indicator.propTypes = {
  fetching: PropTypes.bool
}

Indicator.defaultProps = {
  fetching: false
}

export default Indicator
