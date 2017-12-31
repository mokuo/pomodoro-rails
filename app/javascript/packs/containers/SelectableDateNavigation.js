import { connect } from 'react-redux'
import DateNavigation from '../components/DateNavigation'

const mapStateToProps = state => (
  {
    date: state.date
  }
)

const mapDispatchToProps = () => {
  return {
    onPreviousClick: () => {
      console.log('Previous!!')
    },
    onNextClick: () => {
      console.log('Next!!')
    }
  }
}

const SelectableDateNavigation = connect(
  mapStateToProps,
  mapDispatchToProps
)(DateNavigation)

export default SelectableDateNavigation
