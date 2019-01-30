import React, { Component } from 'react';
import { inject } from 'mobx-react';
import Header from './Header';
import Footer from './Footer';
import FeedbackForm from "./FeedbackForm";

class App extends Component {
  render() {
    return (
      <div>
        <Header title={'Tell us what you think'} />
        <FeedbackForm />
        <Footer />
      </div>
    )
  }
}

export default inject(
  'stores'
)(App);
