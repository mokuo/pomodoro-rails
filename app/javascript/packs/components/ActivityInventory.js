import React from 'react'
import ProjectListContainer from '../containers/ProjectListContainer'
import ErrorAlertContainer from '../containers/ErrorAlertContainer'
import DeleteTaskModal from '../containers/DeleteTaskModal'

const ActivityInventory = () =>
  (
    <div>
      <ErrorAlertContainer />
      <ProjectListContainer />
      <DeleteTaskModal />
    </div>
  )

export default ActivityInventory
