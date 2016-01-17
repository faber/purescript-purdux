module Counter where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console
import Control.Monad.Eff.Random (RANDOM(), randomInt)

import Purdux.Store (STORE(), Store(), dispatch)

data Action
  = Increment
  | Decrement
  | Set Int

newtype State = State { value :: Int }

instance showState :: Show State where
  show (State s) = "State { value: " ++ (show s.value) ++ " }"

update :: Action -> State -> State
update Increment (State s) = State $ s { value = s.value + 1 }
update Decrement (State s) = State $ s { value = s.value - 1 }
update (Set i) (State s) = State $ s { value = i }

initialState :: State
initialState = State { value: 0 }

------------------------------------------------------------

-- | Action Creators aka Triggers

type CounterFX e = (store :: STORE, console :: CONSOLE, random :: RANDOM | e)

increment :: forall e.
             Store State Action (CounterFX e)
          -> Eff (CounterFX e) Unit
increment store = do
  print "Increment!"
  dispatch store Increment

decrement :: forall e.
             Store State Action (CounterFX e)
          -> Eff (CounterFX e) Unit
decrement store = do
  print "Decrement!"
  dispatch store Decrement

randomize :: forall e.
             Store State Action (CounterFX e)
          -> Eff (CounterFX e) Unit
randomize store = do
  print "Randomize!"
  val <- randomInt 0 100
  dispatch store (Set val)
  
