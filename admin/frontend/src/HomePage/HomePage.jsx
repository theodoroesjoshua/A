import React from 'react';
import { Link } from 'react-router-dom';

class HomePage extends React.Component {
  render() {
    return (
      <div>
        <Link to="/vouchers">See Vouchers</Link>
        <br />
        <Link to="/issue">Issue Vouchers</Link>
        <br />
        <Link to="/claim">Claim Vouchers</Link>
      </div>
    );
  }
}

export { HomePage };
