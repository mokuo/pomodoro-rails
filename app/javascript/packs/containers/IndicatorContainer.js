import { connect } from 'react-redux'
import Indicator from '../components/Indicator'

const mapStateToProps = state => (
  {
    fetching: state.fetching
  }
)

const IndicatorContainer = connect(mapStateToProps)(Indicator)

export default IndicatorContainer
