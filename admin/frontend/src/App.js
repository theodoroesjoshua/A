import React from "react";

import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { HomePage } from './HomePage';
import { LoginPage } from './LoginPage';
import { VouchersPage } from './VouchersPage';
import { Navbar } from './_components/Navbar';
import { history } from './_helpers';

export default class App extends React.Component {
  render() {
    return (
      <Router history={history}>
        <Navbar />
        <Routes>
          <Route exact path='/' element={<HomePage />}></Route>
          <Route exact path='/login' element={<LoginPage />}></Route>
          <Route exact path='/vouchers' element={<VouchersPage />}></Route>
        </Routes>
      </Router>
    );
  }
}
