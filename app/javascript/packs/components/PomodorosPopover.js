import React from 'react'
import PropTypes from 'prop-types'
import { Popover, PopoverBody } from 'reactstrap'

const PomodorosPopover = props => {
  const isNew = (props.taskId !== null)
  const isEdit = (props.pomodoroId !== null)
  const box = (name, symbol) => (
    <span
      className="clickable fs-25 mr-2"
      onClick={() => {
        if (isNew) {
          props.createPomodoro(props.taskId, name)
        }
        if (isEdit) {
          props.updatePomodoro(props.pomodoroId, name)
        }
        props.toggle()
      }}
      role="presentation"
    >
      {symbol}
    </span>
  )

  return (
    <Popover
      placement="bottom"
      isOpen={props.isOpen}
      target={props.target}
      toggle={props.toggle}
    >
      <PopoverBody>
        {box('square', '□')}
        {box('circle', '○')}
        {box('triangle', '△')}
        {isEdit &&
          <span>
            <br />
            <a
              href="#"
              onClick={e => {
                e.preventDefault()
                props.togglePomodoro(props.pomodoroId, !props.done)
                props.toggle()
              }}
            >
              {props.done ? '完了をキャンセル' : '完了'}
            </a>
          </span>
        }
      </PopoverBody>
    </Popover>
  )
}

PomodorosPopover.propTypes = {
  isOpen: PropTypes.bool.isRequired,
  target: PropTypes.string.isRequired,
  toggle: PropTypes.func.isRequired,
  taskId: PropTypes.number,
  pomodoroId: PropTypes.number,
  done: PropTypes.bool,
  createPomodoro: PropTypes.func.isRequired,
  updatePomodoro: PropTypes.func.isRequired,
  togglePomodoro: PropTypes.func.isRequired
}

PomodorosPopover.defaultProps = {
  taskId: null,
  pomodoroId: null,
  done: null
}

export default PomodorosPopover
