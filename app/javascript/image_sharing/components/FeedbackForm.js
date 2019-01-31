import React, {Component} from 'react';
import PropTypes from 'prop-types';
import {observer, inject} from 'mobx-react'
import PostFeedbackService from "../services/PostFeedbackService";

@inject('stores')
@observer
class FeedbackForm extends Component {
  static propTypes = {
    stores: PropTypes.objectOf(PropTypes.shape({
      name: PropTypes.string.isRequired,
      feedback: PropTypes.string.isRequired,
    }))
  };

  handleNameChange = (event) => {
    this.props.stores.feedbackStore.setName(event.target.value);
  };

  handleFeedbackChange = (event) => {
    this.props.stores.feedbackStore.setFeedback(event.target.value);
  };

  handleSubmitClick = () => {
    new PostFeedbackService(this.props.stores.feedbackStore).postFeedback();

  }

  render() {
    return (
      <div className="m-5">
        <p className="alert-message">{this.props.stores.feedbackStore.alertMessage}</p>
        <div className="form-group">
          <label>Name:</label>
          <input type="text" name="name" className="form-control" placeholder="Enter Name" value={this.props.stores.feedbackStore.name} onChange={this.handleNameChange}/>
        </div>
        <div className="form-group">
          <label>Feedback:</label>
          <input type="text" name="feedback" className="form-control" placeholder= "Enter Feedback" value={this.props.stores.feedbackStore.feedback} onChange={this.handleFeedbackChange}/>
        </div>
        <button type="submit" className="btn btn-primary" onClick={this.handleSubmitClick} >Submit</button>
      </div>
    )
  }
}

export default FeedbackForm;
