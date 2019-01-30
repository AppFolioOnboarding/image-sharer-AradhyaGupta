import 'jsdom-global/register';
import React from 'react';
import { mount, configure } from 'enzyme';
import { expect } from 'chai';
import Header from '../../components/Header';
import Adapter from 'enzyme-adapter-react-16';

describe('Header', () => {
  configure({ adapter: new Adapter() });

  it('should render sub-components', () => {
    const wrapper = mount(
      <Header title={'Tell us what you think'} />
    );
    expect(wrapper.find('Header').text()).equal('Tell us what you think');
  });
});
