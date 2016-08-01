{-# LANGUAGE RecordWildCards #-}

module LN.Sanitize.ThreadPost (
  sanitizeThreadPostRequest
) where



import           LN.Sanitize.Internal (sanitizeLine)
import           LN.T.ThreadPost      (ThreadPostRequest (..))



sanitizeThreadPostRequest :: ThreadPostRequest -> ThreadPostRequest
sanitizeThreadPostRequest (ThreadPostRequest m_title body tags private_tags guard _ _) =
  ThreadPostRequest
    (sanitizeLine <$> m_title)
    body
    (map sanitizeLine tags)
    (map sanitizeLine private_tags)
    guard
    -- state
    Nothing
    Nothing
