{-# LANGUAGE RecordWildCards #-}

module LN.Sanitize.Organization (
  sanitizeOrganizationRequest
) where



import           LN.Sanitize.Internal      (sanitizeLine)
import           LN.T.Organization.Request (OrganizationRequest (..))



sanitizeOrganizationRequest :: OrganizationRequest -> OrganizationRequest
sanitizeOrganizationRequest (OrganizationRequest display_name desc comp loc email memb tags icon viz guard) =
  OrganizationRequest
    (sanitizeLine display_name)
    (sanitizeLine <$> desc)
    (sanitizeLine comp)
    (sanitizeLine loc)
    (sanitizeLine email)
    memb
    (map sanitizeLine tags)
    icon
    viz
    guard
