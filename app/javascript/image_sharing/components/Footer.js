import React, { Component } from 'react';


const footerStyle = {
  fontSize: '10px'
};

class Footer extends Component {
  render() {
    return(
      <div>
        <footer className='text-center' style={footerStyle} >Copyright: Appfolio Inc. Onboarding</footer>
      </div>
    )
  }
}

export default Footer;
