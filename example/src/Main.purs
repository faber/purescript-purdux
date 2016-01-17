module Main where

import Prelude

import Data.Maybe.Unsafe (fromJust)
import Data.Nullable (toMaybe)

import DOM
import DOM (DOM())
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToDocument)
import DOM.HTML.Window (document)
import DOM.Node.Types (ElementId(..), documentToNonElementParentNode)
import DOM.Node.NonElementParentNode (getElementById)

import Control.Monad.Eff
import Control.Monad.Eff.Console

import qualified Counter as E
import qualified Purdux.Store as S

import Rx.Observable
import Ui.Root (root)
import React as R

main :: Eff (console :: CONSOLE, dom :: DOM, store :: S.STORE) Unit
main = do  
  store <- S.createStore E.update E.initialState

  let app = R.createFactory root { store: store }
  win <- window
  doc <- documentToNonElementParentNode <$>
         htmlDocumentToDocument <$>
         document win
  container <- fromJust <$>
               toMaybe <$>
               getElementById (ElementId "body") doc

  R.render app container
  
  subscribe (S.getState store) (print <<< show)
