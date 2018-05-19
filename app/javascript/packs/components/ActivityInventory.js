import React from 'react'
import ProjectListContainer from '../containers/ProjectListContainer'
import ErrorAlertContainer from '../containers/ErrorAlertContainer'
import UnexpectedErrorAlertContainer from '../containers/UnexpectedErrorAlertContainer'
import DeleteTaskModal from '../containers/DeleteTaskModal'
import IndicatorContainer from '../containers/IndicatorContainer'

const ActivityInventory = () =>
  (
    <div>
      <ErrorAlertContainer />
      <UnexpectedErrorAlertContainer />
      <ProjectListContainer />
      <DeleteTaskModal />
      <IndicatorContainer />
    </div>
  )

export default ActivityInventory
