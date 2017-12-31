import addDays from 'date-fns/add_days'
import format from 'date-fns/format'

const date = (state = window.date, action) => {
  switch (action.type) {
    case 'PREVIOUS_DATE': {
      const priviousDate = addDays(state, -1)
      return format(priviousDate, 'YYYY-MM-DD')
    }
    case 'NEXT_DATE': {
      const nextDate = addDays(state, 1)
      return format(nextDate, 'YYYY-MM-DD')
    }
    default:
      return state
  }
}

export default date
