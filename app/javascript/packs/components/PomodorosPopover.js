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
            if (props.taskId !== null) {
              props.createPomodoro(props.taskId, 'square')
            }
            if (props.pomodoroId !== null) {
              props.updatePomodoro(props.pomodoroId, 'square')
            }
            props.toggle()
          }}
          role="presentation"
        >
          □
        </span>
        <span
          className="clickable fs-25 mr-1"
          onClick={() => {
            if (props.taskId !== null) {
              props.createPomodoro(props.taskId, 'circle')
            }
            if (props.pomodoroId !== null) {
              props.updatePomodoro(props.pomodoroId, 'circle')
            }
            props.toggle()
          }}
          role="presentation"
        >
          ○
        </span>
        <span
          className="clickable fs-25"
          onClick={() => {
            if (props.taskId !== null) {
              props.createPomodoro(props.taskId, 'triangle')
            }
            if (props.pomodoroId !== null) {
              props.updatePomodoro(props.pomodoroId, 'triangle')
            }
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
  taskId: PropTypes.number,
  pomodoroId: PropTypes.number,
  createPomodoro: PropTypes.func.isRequired,
  updatePomodoro: PropTypes.func.isRequired
}

PomodorosPopover.defaultProps = {
  taskId: null,
  pomodoroId: null
}

export default PomodorosPopover
