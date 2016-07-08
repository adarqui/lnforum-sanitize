{-# LANGUAGE RecordWildCards #-}

module LN.Sanitize.Forum (
  sanitizeForumRequest
) where



import           LN.Sanitize.Internal (sanitizeLine)
import           LN.T.Forum           (ForumRequest (..))



sanitizeForumRequest :: ForumRequest -> ForumRequest
sanitizeForumRequest (ForumRequest display_name m_desc threads_per_board posts_per_thread recent_threads_limit recent_posts_limit motw_limit icon tags visibility guard) =
  ForumRequest
    (sanitizeLine display_name)
    (sanitizeLine <$> m_desc)
    threads_per_board
    posts_per_thread
    recent_threads_limit
    recent_posts_limit
    motw_limit
    icon
    (map sanitizeLine tags)
    visibility
    guard
