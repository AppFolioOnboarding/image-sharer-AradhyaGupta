import {observable, action} from "mobx";

export class FeedbackStore {
  @observable name = "";
  @observable feedback = "";
  @observable alertMessage = "";

  @action setName = (name) => {
    this.name = name;
  }

  @action setFeedback = (feedback) => {
    this.feedback = feedback;
  }

  @action setAlertMessage = (alertMessage) => {
    this.alertMessage = alertMessage;
  }
}

export default FeedbackStore;
