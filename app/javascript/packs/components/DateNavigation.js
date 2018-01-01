import React from 'react'
import PropTypes from 'prop-types'

const DateNavigation = props =>
  (
    <nav aria-label="Date navigation">
      <ul className="pagination justify-content-center">
        <li className="page-item">
          <a
            className="page-link"
            href=""
            aria-label="Previous"
            onClick={e => {
              e.preventDefault()
              props.onPreviousClick()
            }}
          >
            <span aria-hidden="true">&lt;</span>
            <span className="sr-only">Previous</span>
          </a>
        </li>
        <li className="page-item disabled">
          <a className="page-link" href="" id="date">{props.date}</a>
        </li>
        <li className="page-item">
          <a
            className="page-link"
            href=""
            aria-label="Next"
            onClick={e => {
              e.preventDefault()
              props.onNextClick()
            }}
          >
            <span aria-hidden="true">&gt;</span>
            <span className="sr-only">Next</span>
          </a>
        </li>
      </ul>
    </nav>
  )

DateNavigation.propTypes = {
  onPreviousClick: PropTypes.func.isRequired,
  date: PropTypes.string.isRequired,
  onNextClick: PropTypes.func.isRequired
}

export default DateNavigation
