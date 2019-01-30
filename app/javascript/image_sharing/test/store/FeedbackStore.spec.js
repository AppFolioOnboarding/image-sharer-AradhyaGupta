import { expect } from 'chai';
import FeedbackStore from "../../stores/FeedbackStore";

describe('FeedbackStore', () => {
  let feedbackStore;
  beforeEach(() => {
    feedbackStore = new FeedbackStore();
  });

  it('should initialize correctly', () => {
    expect(feedbackStore.name).to.equal('');
    expect(feedbackStore.feedback).to.equal('');
  });

  it('setName', () => {
    feedbackStore.setName('Aradhya');
    expect(feedbackStore.name).to.equal('Aradhya');
  });

  it('setFeedback', () => {
    feedbackStore.setFeedback('Awesome!');
    expect(feedbackStore.feedback).to.equal('Awesome!');
  });
});
