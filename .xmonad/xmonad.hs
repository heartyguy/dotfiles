import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen hiding (fullscreenEventHook)
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86
import System.IO

import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- workspace
myWorkspaces = ["1:Main", "2:Web", "3:Code", "4:Aux", "5", "6", "7", "8", "9:Misc"]

-- management
myManageHook = composeAll
    [ className =? "Firefox"         --> doShift "2:Web"
    , className =? "sublime_text"    --> doShift "3:Code"
    , className =? "jetbrains-idea"  --> doShift "3:Code"
    , className =? "lighttable"      --> doShift "3:Code"
    , className =? "LightTable"      --> doShift "3:Code"
    , isFullscreen                   --> doFullFloat ]

-- layout
defaultLayout = tiled ||| Full
  where
    tiled = spacing 2 $ Tall nmaster delta ratio
    nmaster = 1
    ratio = 3/5
    delta = 3/100

-- loghook
myLogHook dest = dynamicLogWithPP $ xmobarPP
    { ppOutput = hPutStrLn dest
    , ppTitle = xmobarColor "green" "" . shorten 50
    }
dimLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.9

-- main
main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ desktopConfig
    { borderWidth          = 0
    , normalBorderColor    = "#343838"
    , focusedBorderColor   = "#008C9E"
    , terminal             = "urxvtc"
    , modMask              = mod4Mask
    , workspaces           = myWorkspaces

    -- hooks
    , manageHook           = manageDocks <+> myManageHook
    , layoutHook           = smartBorders $ avoidStruts defaultLayout
    , startupHook          = setWMName "LG3D"
    , logHook              = dimLogHook >> (myLogHook xmproc)
    , handleEventHook      = fullscreenEventHook
    }
    `additionalKeys`

    [ ((0, xK_Print),                     -- print screen
       spawn "scrot ~/pictures/screenshots/scrot-%Y-%m-%d-%T.png")

    , ((0, xK_Mode_switch),               -- launch
       spawn "dmenu_run")

    , ((mod4Mask .|. shiftMask, xK_w),    -- close
       kill)

    , ((mod4Mask .|. shiftMask, xK_c),    -- disable mod-C
       return ())

    , ((0, xF86XK_MonBrightnessUp),       -- brightness up
       spawn "light -A 5") 

    , ((0, xF86XK_MonBrightnessDown),     -- brightness down
       spawn "light -U 5")

    , ((0, xF86XK_AudioRaiseVolume),      -- volume up
       spawn "amixer -D pulse set Master on  && amixer -D pulse set Master 5%+")

    , ((0, xF86XK_AudioLowerVolume),      -- volume down
       spawn "amixer -D pulse set Master on && amixer -D pulse set Master 5%-")

    , ((0, xF86XK_AudioMute),             -- volume mute
       spawn "amixer -D pulse set Master toggle")

    , ((0, 0x1008FFB2),                   -- mic mute
       spawn "amixer -D pulse set Capture toggle")

    ]
