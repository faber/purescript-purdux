// module Index

// Required for purescript-react, use if rendering from Purescript
// window.React = require('react');
// window.React.render = require('react-dom').render;


import React from 'react';
import ReactDOM from 'react-dom';

import { createStore } from 'Purdux/Store';

import Counter from 'Counter';
import App from 'Ui/App';


const store = createStore(Counter.update)(Counter.initialState)();
ReactDOM.render(
  <App store={store} />,
  document.getElementById('body'));
