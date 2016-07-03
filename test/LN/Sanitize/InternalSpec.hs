{-# LANGUAGE OverloadedStrings #-}

module LN.Sanitize.InternalSpec (
  main,
  spec
) where



import           LN.Sanitize.Internal
import           Test.Hspec



main :: IO ()
main = hspec spec



spec :: Spec
spec = do

  describe "sanitizeLine" $ do
    it "removes leading & trailing whitespace, also consecutive whitespace" $ do
      sanitizeLine "  hello  world  " `shouldBe` "hello world"

  describe "squashSpaces" $ do
    it "condensed consecutive spaces" $ do
      squashSpaces "1 2"  `shouldBe` "1 2"
      squashSpaces "1  2" `shouldBe` "1 2"
