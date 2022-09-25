import { FaBars } from 'react-icons/fa';
import { NavLink as Link } from 'react-router-dom';
import styled from 'styled-components';

export const Nav = styled.nav`
  background: #FAF8BD;
  height: 85px;
  display: flex;
  justify-content: space-between;
  padding: 0.2rem 0.5rem;
  z-index: 12;
  /* Third Nav */
  /* justify-content: flex-start; */
`;

export const NavLogo = styled.div`
  border: 3px solid black;
  border-radius: 15px;
  display: flex;
  align-items: center;
  font-size: 1.2rem;
  height: 70%;
  padding: 0 1rem;
  margin: auto -2rem auto 1rem;
`;

export const NavLink = styled(Link)`
  color: #808080;
  display: flex;
  align-items: center;
  text-decoration: none;
  padding: 0 1rem;
  height: 100%;
  cursor: pointer;
  &.active {
    color: #000000;
  }
`;

export const NavBtn = styled.nav`
  display: flex;
  align-items: center;
  margin-right: 24px;
  /* Third Nav */
  /* justify-content: flex-end;
  width: 100vw; */
  @media screen and (max-width: 768px) {
    display: none;
  }
`;

export const NavBtnLink = styled(Link)`
  border-radius: 4px;
  background: #F4D6E2;
  padding: 10px 22px;
  color: #000000;
  outline: none;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  text-decoration: none;
  /* Second Nav */
  margin-left: 24px;
  &:hover {
    transition: all 0.2s ease-in-out;
    background: #F7ECE7;
    color: #808080;
  }
`;
