import React from 'react'
import DateNavigation from '../containers/DateNavigation'
import ProjectListContainer from '../containers/ProjectListContainer'
import ErrorAlertContainer from '../containers/ErrorAlertContainer'
import UnexpectedErrorAlertContainer from '../containers/UnexpectedErrorAlertContainer'
import DeleteTaskModal from '../containers/DeleteTaskModal'
import IndicatorContainer from '../containers/IndicatorContainer'

const TodoSheet = () =>
  (
    <div>
      <ErrorAlertContainer />
      <UnexpectedErrorAlertContainer />
      <DateNavigation />
      <ProjectListContainer />
      <DeleteTaskModal />
      <IndicatorContainer />
    </div>
  )

export default TodoSheet
