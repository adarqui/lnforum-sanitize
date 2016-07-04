{-# LANGUAGE OverloadedStrings #-}

module LN.Sanitize.UserSpec (
  main,
  spec
) where



import           LN.Sanitize.User
import           LN.T.Internal.JSON ()
import           LN.T.User.Request
import           Test.Hspec



main :: IO ()
main = hspec spec



spec :: Spec
spec = do

  describe "sanitizeUserRequest" $ do
    it "sanitizes a user request" $ do
      sanitizeUserRequest test_user_request `shouldBe` test_user_request'



test_user_request :: UserRequest
test_user_request =
  UserRequest
    " display  name   "
    "Some  Name "
    "helloworld@email.com "
    "  plugin "
    "ident   "
    Nothing



test_user_request' :: UserRequest
test_user_request' =
  UserRequest
    "display name"
    "Some Name"
    "helloworld@email.com"
    "plugin"
    "ident"
    Nothing
