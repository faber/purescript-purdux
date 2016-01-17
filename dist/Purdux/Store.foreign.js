'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.createStore = undefined;

var _rx = require('rx');

var _rx2 = _interopRequireDefault(_rx);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var createStore = exports.createStore = function createStore(reducer) {
  return function (initialState) {
    return function () {
      var actions = new _rx2.default.Subject();
      var state = actions.scan(uncurryAndFlip(reducer), initialState);

      return {
        state: state,
        trigger: function trigger(a) {
          return function () {
            actions.onNext(a);
          };
        }
      };
    };
  };
};

function uncurryAndFlip(fn) {
  return function (a, b) {
    return fn(b)(a);
  };
}

// module Purdux.Store