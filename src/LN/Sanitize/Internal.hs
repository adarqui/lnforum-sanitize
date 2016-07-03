{-# LANGUAGE OverloadedStrings #-}

module LN.Sanitize.Internal (
  sanitizeLine,
  squashSpaces
) where



import           Data.Text (Text)
import qualified Data.Text as T



-- | A simple sanitized line, in which whitespace is trimmed from both ends, and consecutive spaces are squashed
--
sanitizeLine :: Text -> Text
sanitizeLine = T.strip . squashSpaces



-- | Squash consecutive spaces
--
squashSpaces :: Text -> Text
squashSpaces = T.unwords . T.words
