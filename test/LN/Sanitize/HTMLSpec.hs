{-# LANGUAGE OverloadedStrings #-}

module LN.Sanitize.HTMLSpec (
  main,
  spec
) where



import           LN.Sanitize.HTML
import           Test.Hspec



main :: IO ()
main = hspec spec



spec :: Spec
spec = do

  describe "sanitizeHtml" $ do
    it "turns br's into newlines and transforms html entities" $ do
      sanitizeHtml "<br />" `shouldBe` "\n"

      sanitizeHtml
        "VJ&#039;s got upto 25.5&#039;&#039;<br />Front foot elevated split squat 70&#039;s"
        `shouldBe`
        "VJ's got upto 25.5''\nFront foot elevated split squat 70's"
