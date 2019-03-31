{-# LANGUAGE OverloadedStrings #-}

module LN.Sanitize.Internal (
  sanitizeLine,
  toSafeUrl,
  toSafeName,
  squashSpaces,
  decodeEntities
) where



import           Prelude

import           Data.Char              (isAlphaNum)
import           Data.Text              (Text)
import qualified Data.Text              as Text
import           Data.Text.Lazy         (toStrict)
import           Data.Text.Lazy.Builder
import           HTMLEntities.Decoder



-- | A simple sanitized line, in which whitespace is trimmed from both ends, and consecutive spaces are squashed
--
sanitizeLine :: Text -> Text
sanitizeLine = Text.strip . squashSpaces



-- | This is used to generate Name's based on DisplayName's, ie a Forum, Board, Thread, or Resource name
--
-- >> toSafeUrl "1 2 3 -- hello world?!bingo-BOOM"
-- "1-2-3-hello-world-bingo-boom"
--
-- >> toSafeUrl "ADARQ's Journal"
-- "adarqs-journal"
--
-- >> toSafeUrl "ADARQ's Journal's"
-- "adarqs-journals"
--
-- >> toSafeUrl "MOVIES &amp; ENTERTAINMENT &amp; SHeeT!"
-- "movies-entertainment-sheet"
--
toSafeUrl :: Text -> Text
toSafeUrl =
  Text.intercalate "-" .                                   -- replace spaces with dashes
  Text.words .
  Text.map (\c -> if not $ isAlphaNum c then ' ' else c) . -- anything other than alpha numeric becomes a space
  Text.replace "'s" "s " .                                 -- cleans up Ownership's in names
  Text.toLower .
  decodeEntities
  where

decodeEntities :: Text -> Text
decodeEntities = toStrict . Data.Text.Lazy.Builder.toLazyText . htmlEncodedText



-- Original toSafeUrl
-- However, I want to get rid of the replaceAll function which forces us to have a dependency on text-icu, text-regex-replace
--
-- toSafeUrl :: Text -> Text
-- toSafeUrl =
--   Text.intercalate "-" .                                   -- replace spaces with dashes
--   Text.words .
--   Text.map (\c -> if not $ isAlphaNum c then ' ' else c) . -- anything other than alpha numeric becomes a space
--   replaceAll "'s" "s " .                                -- cleans up Ownership's in names
--   Text.toLower



-- | This is used to generate Name's based on DisplayName's, ie an Organization or User name
--
-- >> toSafeName  "Some User Name 123-"
-- "someusername123"
--

toSafeName :: Text -> Text
toSafeName = Text.concat . Text.words . Text.map (\c -> if not $ isAlphaNum c then ' ' else c) . Text.toLower



-- | Squash consecutive spaces
--
squashSpaces :: Text -> Text
squashSpaces = Text.unwords . Text.words
