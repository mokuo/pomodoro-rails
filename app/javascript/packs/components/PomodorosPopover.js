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
        <span
          className="clickable fs-25 mr-2"
          onClick={() => {
            props.onPomodoroClick(props.taskId, 'square')
            props.toggle()
          }}
          role="presentation"
        >
          □
        </span>
        <span
          className="clickable fs-25 mr-1"
          onClick={() => {
            props.onPomodoroClick(props.taskId, 'circle')
            props.toggle()
          }}
          role="presentation"
        >
          ○
        </span>
        <span
          className="clickable fs-25"
          onClick={() => {
            props.onPomodoroClick(props.taskId, 'triangle')
            props.toggle()
          }}
          role="presentation"
        >
          △
        </span>
      </PopoverBody>
    </Popover>
  )

PomodorosPopover.propTypes = {
  isOpen: PropTypes.bool.isRequired,
  target: PropTypes.string.isRequired,
  toggle: PropTypes.func.isRequired,
  taskId: PropTypes.number.isRequired,
  onPomodoroClick: PropTypes.func.isRequired
}

export default PomodorosPopover
