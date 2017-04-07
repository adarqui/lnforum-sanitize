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

  describe "toSafeUrl" $ do
    it "makes urls pretty" $ do
      toSafeUrl "1 2 3 -- hello world?!bingo-BOOM" `shouldBe` "1-2-3-hello-world-bingo-boom"
      toSafeUrl "ADARQ's Journal"                  `shouldBe` "adarqs-journal"
      toSafeUrl "ADARQ's Journal's"                `shouldBe` "adarqs-journals"

  describe "toSafeName" $ do
    it "makes display names safe, by removing various characters etc" $ do
      toSafeName "Some User Name 123-" `shouldBe` "someusername123"

  describe "squashSpaces" $ do
    it "condensed consecutive spaces" $ do
      squashSpaces "1 2"  `shouldBe` "1 2"
      squashSpaces "1  2" `shouldBe` "1 2"
