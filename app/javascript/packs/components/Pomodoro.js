import React, { Component } from 'react'
import PropTypes from 'prop-types'
import PomodorosPopoverContainer from '../containers/PomodorosPopoverContainer'

class Pomodoro extends Component {
  constructor(props) {
    super(props)
    this.state = {
      popoverIsOpen: false
    }
    this.togglePopover = this.togglePopover.bind(this)
    this.symbol = this.symbol.bind(this)
  }

  togglePopover() {
    this.setState({ popoverIsOpen: !this.state.popoverIsOpen })
  }

  symbol() {
    switch (this.props.box) {
      case 'square':
        return '□'
      case 'circle':
        return '○'
      case 'triangle':
        return '△'
      default:
        return ''
    }
  }

  render() {
    const target = `pomodoro${this.props.id}`

    return (
      <td
        id={target}
        className="pomodoro-box text-center clickable"
        width="48"
        onClick={() => this.togglePopover()}
      >
        {this.symbol()}
        <PomodorosPopoverContainer
          isOpen={this.state.popoverIsOpen}
          target={target}
          toggle={this.togglePopover}
          pomodoroId={this.props.id}
        />
      </td>
    )
  }
}

Pomodoro.propTypes = {
  id: PropTypes.number.isRequired,
  box: PropTypes.string.isRequired
}

export default Pomodoro
