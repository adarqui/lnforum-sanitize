{-# LANGUAGE OverloadedStrings #-}

module LN.Sanitize.Internal (
  sanitizeLine,
  toSafeUrl,
  toSafeName,
  squashSpaces
) where



import           Data.Char             (isAlphaNum)
import           Data.Text             (Text)
import qualified Data.Text             as T



-- | A simple sanitized line, in which whitespace is trimmed from both ends, and consecutive spaces are squashed
--
sanitizeLine :: Text -> Text
sanitizeLine = T.strip . squashSpaces



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
toSafeUrl :: Text -> Text
toSafeUrl =
  T.intercalate "-" .                                   -- replace spaces with dashes
  T.words .
  T.map (\c -> if not $ isAlphaNum c then ' ' else c) . -- anything other than alpha numeric becomes a space
  T.replace "'s" "s " .                                 -- cleans up Ownership's in names
  T.toLower



-- Original toSafeUrl
-- However, I want to get rid of the replaceAll function which forces us to have a dependency on text-icu, text-regex-replace
--
-- toSafeUrl :: Text -> Text
-- toSafeUrl =
--   T.intercalate "-" .                                   -- replace spaces with dashes
--   T.words .
--   T.map (\c -> if not $ isAlphaNum c then ' ' else c) . -- anything other than alpha numeric becomes a space
--   replaceAll "'s" "s " .                                -- cleans up Ownership's in names
--   T.toLower



-- | This is used to generate Name's based on DisplayName's, ie an Organization or User name
--
-- >> toSafeName  "Some User Name 123-"
-- "someusername123"
--

toSafeName :: Text -> Text
toSafeName = T.concat . T.words . T.map (\c -> if not $ isAlphaNum c then ' ' else c) . T.toLower



-- | Squash consecutive spaces
--
squashSpaces :: Text -> Text
squashSpaces = T.unwords . T.words
