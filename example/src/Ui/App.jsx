import React from 'react';
import Rx from 'rx';
import Counter from 'Counter';
import { getState, dispatch } from 'Purdux/Store';

const PT = React.PropTypes;

export default class App extends React.Component {

  constructor(props) {
    super(props);
    this.state = Counter.initialState;

    const store = this.props.store;
    this.triggers = {
      increment: Counter.increment(store),
      decrement: Counter.decrement(store),
      randomize: Counter.randomize(store)
    };
  }

  componentWillMount() {
    const state$ = getState(this.props.store);
    state$.subscribe(this.setState.bind(this));
  }

  render() {
    return (
      <div>
        <h1>Purdux Counter</h1>
        <p>{this.state.value}</p>
        <button onClick={this.triggers.increment}>
          increment
        </button>
        <button onClick={this.triggers.decrement}>
          decrement
        </button>
        <button onClick={this.triggers.randomize}>
          randomize
        </button>
      </div>
    );
  }
};

App.displayName = 'App';
App.propTypes = {
  store: PT.object.isRequired
};
