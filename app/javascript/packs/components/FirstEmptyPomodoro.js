import React, { Component } from 'react'
import PropTypes from 'prop-types'
import PomodorosPopover from '../components/PomodorosPopover'

class FirstEmptyPomodoro extends Component {
  constructor(props) {
    super(props)
    this.state = {
      popoverIsOpen: false
    }
    this.togglePopover = this.togglePopover.bind(this)
  }

  togglePopover() {
    this.setState({ popoverIsOpen: !this.state.popoverIsOpen })
  }

  render() {
    const target = `task${this.props.taskId}-first-empty-pomodoro`
    return (
      <td
        id={target}
        className="pomodoro-box clickable"
        width="48"
        onClick={() => this.togglePopover()}
      >
        <PomodorosPopover
          isOpen={this.state.popoverIsOpen}
          target={target}
          toggle={this.togglePopover}
        />
      </td>
    )
  }
}

FirstEmptyPomodoro.propTypes = {
  taskId: PropTypes.number.isRequired
}

export default FirstEmptyPomodoro
