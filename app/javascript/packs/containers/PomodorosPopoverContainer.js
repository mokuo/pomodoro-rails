import { connect } from 'react-redux'
import PomodorosPopover from '../components/PomodorosPopover'
import { createPomodoro, updatePomodoro } from '../actions/pomodoros'

const mapStateToProps = () => ({})

const mapDispatchToProps = dispatch => (
  {
    createPomodoro: (taskId, box) => {
      dispatch(createPomodoro(taskId, box))
    },
    updatePomodoro: (id, box) => {
      dispatch(updatePomodoro(id, box))
    }
  }
)

const PomodorosPopoverContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(PomodorosPopover)

export default PomodorosPopoverContainer
