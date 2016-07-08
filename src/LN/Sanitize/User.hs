{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module LN.Sanitize.User (
  sanitizeUserRequest
) where



import           LN.Sanitize.Internal (sanitizeLine)
import           LN.T.User            (UserRequest (..))



sanitizeUserRequest :: UserRequest -> UserRequest
sanitizeUserRequest (UserRequest display_name full_name email plugin ident tos) =
  UserRequest
    (sanitizeLine display_name)
    (sanitizeLine full_name)
    (sanitizeLine email)
    (sanitizeLine plugin)
    (sanitizeLine ident)
    tos
