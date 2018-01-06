import React from 'react'
import PropTypes from 'prop-types'
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap'
import { connect } from 'react-redux'
import { closeModal } from '../actions/modals'
import { deleteTask } from '../actions/tasks'

const RawDeleteTaskModal = props =>
  (
    <Modal isOpen={props.isOpen} toggle={props.closeModal}>
      <ModalHeader toggle={props.closeModal}>タスクを削除してよろしいですか？</ModalHeader>
      <ModalBody>
        {props.taskName}
      </ModalBody>
      <ModalFooter>
        <Button color="danger" onClick={() => props.deleteTask(props.taskId)}>削除</Button>
        <Button color="secondary" onClick={props.closeModal}>キャンセル</Button>
      </ModalFooter>
    </Modal>
  )

RawDeleteTaskModal.propTypes = {
  isOpen: PropTypes.bool.isRequired,
  taskId: PropTypes.number,
  taskName: PropTypes.string,
  closeModal: PropTypes.func.isRequired,
  deleteTask: PropTypes.func.isRequired
}

RawDeleteTaskModal.defaultProps = {
  taskId: null,
  taskName: null
}

const mapStateToProps = state => (
  {
    isOpen: state.modals.deleteTaskModal.isOpen,
    taskId: state.modals.deleteTaskModal.taskId,
    taskName: state.modals.deleteTaskModal.taskName
  }
)

const mapDispatchToProps = dispatch => (
  {
    closeModal: () => {
      dispatch(closeModal())
    },
    deleteTask: id => {
      dispatch(deleteTask(id))
    }
  }
)

const DeleteTaskModal = connect(
  mapStateToProps,
  mapDispatchToProps
)(RawDeleteTaskModal)

export default DeleteTaskModal
