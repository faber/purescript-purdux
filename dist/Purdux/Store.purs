module Purdux.Store where

import Prelude
import Control.Monad.Eff
import Rx.Observable

foreign import data STORE :: !

type Store s a e = {
  state :: Observable s,
  trigger :: a -> Eff (store :: STORE | e) Unit
}

foreign import createStore :: forall a s e.
                              (a -> s -> s)
                           -> s
                           -> Eff (store :: STORE | e) (Store s a e)

getState :: forall s a e. Store s a e -> Observable s
getState = _.state

dispatch :: forall s a e. Store s a e -> a -> Eff (store :: STORE | e) Unit
dispatch s a = s.trigger a
