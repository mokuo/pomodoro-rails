import React from 'react'
import PropTypes from 'prop-types'
import { Popover, PopoverBody } from 'reactstrap'

const PomodorosPopover = props =>
  (
    <Popover
      placement="bottom"
      isOpen={props.isOpen}
      target={props.target}
      toggle={props.toggle}
    >
      <PopoverBody>test</PopoverBody>
    </Popover>
  )

PomodorosPopover.propTypes = {
  isOpen: PropTypes.bool.isRequired,
  target: PropTypes.string.isRequired,
  toggle: PropTypes.func.isRequired
}

export default PomodorosPopover
