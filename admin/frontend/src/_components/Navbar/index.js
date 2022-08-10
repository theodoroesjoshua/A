// We import bootstrap to make our application look better.
import "bootstrap/dist/css/bootstrap.css";
import React, { Component } from "react";

import {
  Nav,
  NavLink,
  NavBtn,
  NavBtnLink,
  NavLogo,
} from './NavbarElements';

export default class Navbar extends Component {

  render() {
    return (
      <div>
        <Nav>
          <NavLogo>
            <NavLink to ='/' exact activeStyle> Desushi Admin Dashboard </NavLink>
          </NavLogo>

          <NavBtn>
            <NavBtnLink to='/login'> LOG IN </NavBtnLink>
          </NavBtn>
        </Nav>
      </div>
    );
  }
}
