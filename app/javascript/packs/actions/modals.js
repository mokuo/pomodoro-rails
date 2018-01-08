export const openDeleteTaskModal = (taskId, taskName) => (
  {
    type: 'OPEN_DELETE_TASK_MODAL',
    taskId,
    taskName
  }
)

export const closeModal = () => (
  {
    type: 'CLOSE_MODAL'
  }
)
