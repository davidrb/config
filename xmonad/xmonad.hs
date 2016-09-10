{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, PatternGuards, TypeSynonymInstances, DeriveDataTypeable #-}

import XMonad
import XMonad.Core(LayoutClass)
import qualified Data.Map as M
import qualified XMonad.StackSet as W

import XMonad.Util.EZConfig( additionalKeys )
import XMonad.Util.Run

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad

import XMonad.Layout.WorkspaceDir
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.InsertPosition

import XMonad.Actions.NoBorders

main = do
      h <- spawnPipe "xmobar -a left -o"
      xmonad $ myConfig h

myConfig h = additionalKeys (defaultConfig {    
    borderWidth = 1,
    terminal = "terminator",
    startupHook = myStartup,
    layoutHook = myLayout,
    manageHook = myManage,
    logHook = myLog h,
    workspaces = myWorkspaces,
    handleEventHook = docksEventHook
}) myKeys

myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1..9]

myLog h = dynamicLogWithPP $ defaultPP { ppOutput=hPutStrLn h }

myManage = manageDocks

myLayout = modWorkspaces myWorkspaces smartBorders $ 
           modWorkspaces myWorkspaces avoidStruts $ 
           modWorkspace "1" (workspaceDir "/home/david") $ 
           (tiled ||| Main ||| Secondary ||| Full)
                where tiled = (Tall 1 (3/100) (1/2))

myKeys = [
    ((mod1Mask .|. shiftMask, xK_x), changeDir defaultXPConfig)
    ,((mod1Mask .|. shiftMask, xK_b), spawn "uzbl-browser")
    ,((mod1Mask,  xK_g ), withFocused toggleBorder)
    ,((mod1Mask,  xK_s ), sendMessage ToggleStruts)
    ,((mod1Mask,  xK_u ), withFocused unmanage)]

myStartup = do
	  spawn "unclutter --timeout 1"
          spawn "nitrogen --restore"
          spawn "trayer --height 35 --SetDockType true --widthtype percent --width 3 --expand true --SetPartialStrut true --alpha 255 --align right --edge top"
          spawn "pa-applet"
          spawn "mate-power-manager"
          spawn "nm-applet"

-- Main Layout
data Main a = Main deriving (Show, Read)

instance LayoutClass Main a where
    description _ = "Main Layout"

    pureLayout _ r@(Rectangle rx ry rw rh) s = zip ws rs
        where ws = W.integrate s
              rs = mainTile r (length ws)

mainTile r n = if (n <= 3) 
               then splitHorizontally n r
               else r1:r2:rs
                  where r1:r2:r3:_ = splitHorizontally 3 r
                        rs = splitVertically (n-2) r3

-- Secondary Layout
data Secondary a = Secondary deriving (Show, Read)

instance LayoutClass Secondary a where
    description _ = "Secondary Layout"

    pureLayout _ r@(Rectangle rx ry rw rh) s = zip ws rs
        where ws = W.integrate s
              rs = secondaryTile r (length ws)

secondaryTile r@(Rectangle rx ry rw rh) n = masterR:(stashedRs++leftRs)
    where dx = rw `div` 4
          dy = rh `div` 4
          numLeft = min (n-1) 3
          masterR = if (numLeft == 0) 
                    then r
                    else if (n > 4) 
                        then (Rectangle (rx + fromIntegral dx) ry (3*dx) (3*dy))
                        else (Rectangle (rx + fromIntegral dx) ry (3*dx) rh)
          leftRs = splitVertically numLeft (Rectangle rx ry dx rh)
          stashedRs = if (n < 5) 
                      then []
                      else splitHorizontally (n-4) (Rectangle (rx + fromIntegral dx) (ry + fromIntegral (3*dy)) (3*dx) dy)
