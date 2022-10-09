// We import bootstrap to make our application look better.
import "bootstrap/dist/css/bootstrap.css";
import React from "react";
import { authenticationService } from '../../_services';
import { withRouter } from '../../_helpers';

import {
  Nav,
  NavLink,
  NavBtn,
  NavBtnLink,
  NavLogo,
} from './NavbarElements';

class NavbarComponent extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
        currentUser: null
    };
  }

  componentDidMount() {
    authenticationService.currentUser.subscribe(x => this.setState({
        currentUser: x
    }));
  }

  logout() {
    authenticationService.logout();
    this.props.navigate('/login');
  }

  render() {
    const { currentUser } = this.state;

    const LoginButton = () => (
      <NavBtn>
        <NavBtnLink to='/login'> LOG IN </NavBtnLink>
      </NavBtn>
    )

    const LogoutButton = () => (
      <NavBtn onClick={this.logout.bind(this)}>
        <NavBtnLink to='#'> LOG OUT </NavBtnLink>
      </NavBtn>
    )

    const button = (currentUser) ? <LogoutButton /> : <LoginButton />;

    return (
      <div>
        <Nav>
          <NavLogo>
            <NavLink to ='/' exact activeStyle> Desushi Admin Dashboard </NavLink>
          </NavLogo>

          {button}
        </Nav>
      </div>
    );
  }
}

export const Navbar = withRouter(NavbarComponent);
