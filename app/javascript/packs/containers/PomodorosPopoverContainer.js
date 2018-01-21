import { connect } from 'react-redux'
import PomodorosPopover from '../components/PomodorosPopover'
import { createPomodoro } from '../actions/pomodoros'

const mapStateToProps = () => ({})

const mapDispatchToProps = dispatch => (
  {
    onPomodoroClick: (taskId, box) => {
      dispatch(createPomodoro(taskId, box))
    }
  }
)

const PomodorosPopoverContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(PomodorosPopover)

export default PomodorosPopoverContainer
