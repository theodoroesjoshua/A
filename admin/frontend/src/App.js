import React from "react";

import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { HomePage } from './HomePage';

export default class App extends React.Component {
  render() {
    return (
      <Router>
        <Routes>
          <Route exact path='/' element={<HomePage />}></Route>
        </Routes>
      </Router>
    );
  }
}
