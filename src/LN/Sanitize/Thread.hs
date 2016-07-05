{-# LANGUAGE RecordWildCards #-}

module LN.Sanitize.Thread (
  sanitizeThreadRequest
) where



import           LN.Sanitize.Internal (sanitizeLine)
import           LN.T.Thread.Request   (ThreadRequest (..))



sanitizeThreadRequest :: ThreadRequest -> ThreadRequest
sanitizeThreadRequest (ThreadRequest display_name m_desc sticky locked poll icon tags guard) =
  ThreadRequest
    (sanitizeLine display_name)
    (sanitizeLine <$> m_desc)
    sticky
    locked
    poll
    icon
    (map sanitizeLine tags)
    guard
