import 'jsdom-global/register';
import React from 'react';
import { mount, configure } from 'enzyme';
import { expect } from 'chai';
import sinon from 'sinon';
import Adapter from 'enzyme-adapter-react-16';
import FeedbackStore from "../../stores/FeedbackStore";
import FeedbackForm from "../../components/FeedbackForm";

describe('<FooterFeedback />', () => {
  configure({ adapter: new Adapter() });

  it('should update form values when store is changed', () => {
    const store = new FeedbackStore();
    const wrapper = mount(
      <FeedbackForm stores={{feedbackStore: store}}/>
    );

    expect(wrapper.find('input[name="name"]').props().value).to.equal('');
    expect(wrapper.find('input[name="feedback"]').props().value).to.equal('');

    const name = "Aradhya";
    const feedback = "Awesome!";

    store.setName(name);
    store.setFeedback(feedback);

    wrapper.update();

    expect(wrapper.find('input[name="name"]').props().value).to.equal(name);
    expect(wrapper.find('input[name="feedback"]').props().value).to.equal(feedback);
  });

  it('should update store when changed', () => {
    const store = new FeedbackStore();
    const wrapper = mount(
      <FeedbackForm stores={{feedbackStore: store}}/>
    );

    const nameSpy = sinon.spy(store, 'setName');
    const feedbackSpy = sinon.spy(store, 'setFeedback');

    expect(wrapper.find('input[name="name"]').props().value).to.equal('');
    expect(wrapper.find('input[name="feedback"]').props().value).to.equal('');

    const name = "Aradhya";
    const feedback = "Awesome!";

    wrapper.find('input[name="name"]').simulate('change', {target: {value: name}});
    wrapper.find('input[name="feedback"]').simulate('change', {target: {value: feedback}});

    expect(nameSpy.calledWith(name)).to.be.true;
    expect(feedbackSpy.calledWith(feedback)).to.be.true;
    });

  it('should show alert message', () => {
    const store = new FeedbackStore();
    const alert = "An error occurred";

    store.setAlertMessage(alert);
    const wrapper = mount(
      <FeedbackForm stores={{feedbackStore: store}} />
    );

    expect(wrapper.find('.alert-message').text()).to.equal(alert);
  })
});
