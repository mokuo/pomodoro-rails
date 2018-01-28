import { connect } from 'react-redux'
import PomodorosPopover from '../components/PomodorosPopover'
import { createPomodoro, updatePomodoro, togglePomodoro, deletePomodoro } from '../actions/pomodoros'

const mapStateToProps = () => ({})

const mapDispatchToProps = dispatch => (
  {
    createPomodoro: (taskId, box) => {
      dispatch(createPomodoro(taskId, box))
    },
    updatePomodoro: (id, box) => {
      dispatch(updatePomodoro(id, box))
    },
    togglePomodoro: (id, done) => {
      dispatch(togglePomodoro(id, done))
    },
    deletePomodoro: id => {
      dispatch(deletePomodoro(id))
    }
  }
)

const PomodorosPopoverContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(PomodorosPopover)

export default PomodorosPopoverContainer
