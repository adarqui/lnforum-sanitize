{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module LN.Sanitize.User (
  sanitizeUserRequest
) where



import           LN.Sanitize.Internal (sanitizeLine)
import           LN.T.User.Request    (UserRequest (..))



sanitizeUserRequest :: UserRequest -> UserRequest
sanitizeUserRequest (UserRequest display_nick name email plugin ident tos) =
  UserRequest
    (sanitizeLine display_nick)
    (sanitizeLine name)
    (sanitizeLine email)
    (sanitizeLine plugin)
    (sanitizeLine ident)
    tos
