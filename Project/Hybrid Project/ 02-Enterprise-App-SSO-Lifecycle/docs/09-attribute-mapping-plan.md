# Attribute Mapping Plan

## Goal
Define the minimum identity attributes that would be required if downstream provisioning were enabled for this application.

## Proposed Core User Mapping
- userPrincipalName -> login / username
- displayName -> display name
- givenName -> first name
- surname -> last name
- mail -> email
- accountEnabled / active state -> active status

## Matching Strategy
Primary matching key should be the cloud sign-in identity used for SSO, ideally the same value as the application login name.

## Group Context
Application access is currently controlled by enterprise app assignment through synced security groups.

## Important Design Note
Actual attribute mappings must match the target application schema.
This document is a design plan, not proof that the target app accepts these mappings.
