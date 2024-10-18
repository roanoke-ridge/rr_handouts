# rr_handouts

## Purpose
This resource allows you to pay all players in your server a set amount at a set interval, regardless of job. It creates a separate timer per player so that it pays them for their own playtime, instead of everyone being paid at once regardless of their individual playtime.

## Configuration
The config resides in `shared/config.lua`  
Strings can be changed in `locales/*.json`

## Dependencies
- [VORP Core](https://github.com/VORPCORE/vorp_core-lua)
- [ox_lib](https://github.com/overextended/ox_lib) for localization and timers
  - For localization, you'll need to follow the setup instructions [here](https://overextended.dev/ox_lib/Modules/Locale/Shared)
  - You can either edit the existing `locales/en.json` or create a new `locales/[langcode].json` file with your own strings
