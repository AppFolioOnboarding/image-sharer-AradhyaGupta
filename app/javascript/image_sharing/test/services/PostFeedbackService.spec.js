import { expect } from 'chai';
import FeedbackStore from "../../stores/FeedbackStore";
import sinon from "sinon";
import * as apiHelper from "../../utils/helper";
import React from "react";
import PostFeedbackService from "../../services/PostFeedbackService";


describe('PostFeedbackService', () => {
  let sandbox;

  beforeEach(() => {
    sandbox = sinon.createSandbox();
  });

  afterEach(() => {
    sandbox.restore()
  });

  it('should successfully post', () => {
    const store = new FeedbackStore();
    const postStub = sandbox.stub(apiHelper, 'post').resolves();

    return new PostFeedbackService(store).postFeedback().then(() => {
      sinon.assert.calledOnce(postStub);
      expect(store.alertMessage).to.equal('Feedback submitted');
    });
  });

  it('should fail', () => {
    const store = new FeedbackStore();
    const postStub = sandbox.stub(apiHelper, 'post').rejects();

    return new PostFeedbackService(store).postFeedback().then(() => {
      sinon.assert.calledOnce(postStub);
      expect(store.alertMessage).to.equal('An error occurred');
    });
  });
});

