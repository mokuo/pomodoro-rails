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
      <PopoverBody>
        <span className="pomodoro square mr-2" />
        <span className="pomodoro circle mr-2" />
        <span className="pomodoro triangle" />
      </PopoverBody>
    </Popover>
  )

PomodorosPopover.propTypes = {
  isOpen: PropTypes.bool.isRequired,
  target: PropTypes.string.isRequired,
  toggle: PropTypes.func.isRequired
}

export default PomodorosPopover
