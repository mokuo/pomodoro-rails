import React from 'react'
import PropTypes from 'prop-types'
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap'
import { connect } from 'react-redux'
import { closeModal } from '../actions/modals'
import { deleteTask } from '../actions/tasks'

const RawDeleteTaskModal = props =>
  (
    <Modal isOpen={props.modal.isOpen} toggle={props.closeModal}>
      <ModalHeader toggle={props.closeModal}>タスクを削除してよろしいですか？</ModalHeader>
      <ModalBody>
        {props.modal.taskName}
      </ModalBody>
      <ModalFooter>
        <Button
          color="danger"
          onClick={() => {
            props.deleteTask(props.modal.taskId)
            props.closeModal()
          }}
        >
          削除
        </Button>
        <Button color="secondary" onClick={props.closeModal}>キャンセル</Button>
      </ModalFooter>
    </Modal>
  )

RawDeleteTaskModal.propTypes = {
  modal: PropTypes.shape({
    isOpen: PropTypes.bool.isRquired,
    taskId: PropTypes.number,
    taskName: PropTypes.string
  }).isRequired,
  closeModal: PropTypes.func.isRequired,
  deleteTask: PropTypes.func.isRequired
}

const mapStateToProps = state => (
  {
    modal: state.modals.get('deleteTaskModal').toJS()
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
