-- |

module Diagrams.Test.Direction where


import           Diagrams.Direction
import           Diagrams.Prelude
import           Instances
import           Test.Tasty
import           Test.Tasty.QuickCheck

tests :: TestTree
tests = testGroup "Direction" [
         testProperty "Length does not effect from direction" $
           \(Positive f) (NonZero v) -> fromDirection(dir ((v  :: V2 Double) ^* (f+0.001))) =~ fromDirection(dir v)
         , testProperty "HasTheta subtraction yeilds same result as anglebetween" $
            (anglebetsub)
         , testProperty "anglebetweenDirs is commutative" $
           \a b -> angleBetweenDirs (a :: Direction V2 Double) b =~ angleBetweenDirs b a
         , testProperty "fromdirection does not effect angleBetweenDirs" $
           \a b -> angleBetween (fromDirection (a  :: Direction V2 Double)) (fromDirection b) =~ angleBetweenDirs a b



      ]

if' :: Bool -> a -> a -> a
if' True  x _ = x
if' False _ y = y

anglebetsub :: Direction V2 Double -> Direction V2 Double -> Bool
anglebetsub a b = (if' (abs (a ^.  _theta^.rad  - b ^. _theta^.rad) < pi)
                       (abs ((a ^.  _theta  ^-^ b ^. _theta)^.rad))
                       (2*pi - abs (a ^.  _theta^.rad  - b ^. _theta^.rad) ) =~ angleBetweenDirs a b ^.rad)
