{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances #-}

module Monads.Transformers.NonDetT where

import Monads.Classes
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.List
import Util
import Monads.Transformers.ListSetT

newtype NonDetT m a = NonDetT { unNonDetT :: ListSetT m a}
  deriving 
  ( Monad
  , MonadTrans
  , MonadFunctor
  , MonadMonad
  , MonadPlus
  , MonadReader r
  , MonadState s
  , MonadEnvReader env
  , MonadEnvState env
  , MonadStoreState store
  , MonadTimeState time
  )

mkNonDetT :: m (ListSet a) -> NonDetT m a
mkNonDetT = NonDetT . ListSetT

runNonDetT :: NonDetT m a -> m (ListSet a)
runNonDetT = runListSetT . unNonDetT

instance (Monad m) => MonadMorph ListSet (NonDetT m) where
  mmorph = NonDetT . mmorph
