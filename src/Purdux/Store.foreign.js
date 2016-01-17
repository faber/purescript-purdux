

import Rx from 'rx';

export const createStore = reducer => initialState => () => {
  const actions = new Rx.Subject();  
  const state = actions.scan(uncurryAndFlip(reducer), initialState);

  return {
    state,
    trigger: a => () => {
      actions.onNext(a);
    }
  };
};

function uncurryAndFlip(fn) {
  return function(a, b) {
    return fn(b)(a);
  };
}



// module Purdux.Store

