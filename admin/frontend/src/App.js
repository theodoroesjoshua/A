import React from "react";

import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { HomePage } from './HomePage';
import Navbar from "./_components/Navbar";

export default class App extends React.Component {
  render() {
    return (
      <Router>
        <Navbar />
        <Routes>
          <Route exact path='/' element={<HomePage />}></Route>
        </Routes>
      </Router>
    );
  }
}
