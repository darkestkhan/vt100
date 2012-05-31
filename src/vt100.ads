pragma License (GPL);
------------------------------------------------------------------------------
-- EMAIL: <darkestkhan@gmail.com>                                           --
-- License: GNU GPLv3 or any later as published by Free Software Foundation --
-- (see README file)                                                        --
--                    Copyright © 2011 - 2012 darkestkhan                   --
------------------------------------------------------------------------------
--  This Program is Free Software: You can redistribute it and/or modify    --
--  it under the terms of The GNU General Public License as published by    --
--    the Free Software Foundation, either version 3 of the license, or     --
--                (at Your option) any later version.                       --
--                                                                          --
--      This Program is distributed in the hope that it will be useful,     --
--      but WITHOUT ANY WARRANTY; without even the implied warranty of      --
--      MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE. See the        --
--              GNU General Public License for more details.                --
--                                                                          --
--    You should have received a copy of the GNU General Public License     --
--   along with this program. If not, see <http://www.gnu.org/licenses/>.   --
------------------------------------------------------------------------------
-- This library is simple and rather minimal ANSI/VT100 API wrapper for Ada
package VT100 is

        ---------------------------------
        -- T E R M I N A L   S E T U P --
        ---------------------------------

  procedure Reset;
  -- Reset all terminal settings to default.

  procedure Line_Wrapping
    (State  : in Boolean);
  -- If state is True then text wraps to next line if longer than the length
  -- of the display area.

        -----------------------------------
        -- S C R E E N   C L E A R I N G --
        -----------------------------------

  procedure Clear_Screen;
  -- Clears screen.

  procedure Erase_Line;
  -- Erase everything in line at which cursor is positioned.

  type Direction is (Up, Down, Forward, Backward);

  procedure Erase
    (Where  : in Direction);
  -- Erase in given direction:
    -- Up       : Erases screen from current line to the top of the screen.
    -- Down     : Erases screen from current line to the bottom of the screen.
    -- Forward  : Erases from cursor position to the end of current line.
    -- Backward : Erases from cursor position to the beginning of current line.

        -------------------------------
        -- C U R S O R   M O V I N G --
        -------------------------------

  procedure Move_Cursor
    (Line   : in Natural;
     Column : in Natural);
  -- Moves cursor to position specified by coordinates.
  -- Position (0, 0) is upper left corner of screen.

  procedure Move_Cursor
    (Where : Direction;
     By    : in Natural);
  -- Moves cursor in Direction by By positions.

  procedure Save_Cursor_Position;
  -- Saves current cursor position in internal state of VT100 capable terminal.

  procedure Restore_Cursor_Position;
  -- Moves cursor to position stored in internal state of terminal.

        ---------------------------------------
        -- A T T R I B U T E   S E T T I N G --
        ---------------------------------------

  type Attribute is (Reset, Bold, Dim, Underline, Blink, Revers, Hidden);
  -- Attributes that can be set by calls to VT100 API:
    -- Reset      : reset all attributes
    -- Bold       : all new text will be printed in bold font
    -- Dim        : all new text will be printed in dim colored font
    -- Underline  : all new text will be printed with underline
    -- Blink      : cursor will start/stop blinking
    -- Revers     : reverses colours in which new text will printed
    -- Hidden     : all new text that will be printed will be invisible

  procedure Set_Attribute
    (This: in Attribute);
  -- Sets attribute on.

        -------------------------------
        -- C O L O R   S E T T I N G --
        -------------------------------

  type Color is (Black, Red, Green, Yellow, Blue,
                 Magenta, Cyan, White, Default);
  -- Colors specified by VT100 API

  procedure Set_Foreground_Color
    (This: in Color);
  -- Sets font color.

  procedure Set_Background_Color
    (This: in Color);
  -- Sets background color.

        ---------------------
        -- P R I N T I N G --
        ---------------------
  -- Local printing support.

  procedure Print_Screen;
  -- Print the current screen.

  procedure Print_Line;
  -- Print the current line.

  procedure Print_Log
    (State  : in Boolean);
  -- Set printing log - if True then all received text is echoed to a printer.

end VT100;
