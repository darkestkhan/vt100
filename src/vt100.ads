------------------------------------------------------------------------------
-- EMAIL: <darkestkhan@gmail.com>                                           --
-- License: ISC License (see COPYING file)                                  --
--                                                                          --
--                    Copyright © 2011 - 2015 darkestkhan                   --
------------------------------------------------------------------------------
-- Permission to use, copy, modify, and/or distribute this software for any --
-- purpose with or without fee is hereby granted, provided that the above   --
-- copyright notice and this permission notice appear in all copies.        --
--                                                                          --
-- The software is provided "as is" and the author disclaims all warranties --
-- with regard to this software including all implied warranties of         --
-- merchantability and fitness. In no event shall the author be liable for  --
-- any special, direct, indirect, or consequential damages or any damages   --
-- whatsoever resulting from loss of use, data or profits, whether in an    --
-- action of contract, negligence or other tortious action, arising out of  --
-- or in connection with the use or performance of this software.           --
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

        ---------------
        -- F O N T S --
        ---------------

  procedure Use_Default_Font;
  -- Print in default font.

  procedure Use_Alternate_Font;
  -- Print in alternate font.

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
  -- Moves cursor in direction WHERE by BY positions.

  procedure Save_Cursor_Position;
  -- Saves current cursor position in internal state of VT100 capable terminal.

  procedure Restore_Cursor_Position;
  -- Moves cursor to position stored in internal state of terminal.

        ---------------------------
        -- T A B   C O N T R O L --
        ---------------------------

  procedure Set_Tab;
  -- Sets a tab at the current position.

  procedure Clear_Tab;
  -- Clears tab at the current position.

  procedure Clear_All_Tabs;
  -- Clears all tabs.

        -----------------------
        -- S C R O L L I N G --
        -----------------------

  procedure Scroll_Screen;
  -- Enable scrolling for entire display.

  procedure Scroll_Screen
    (From : in Natural;
     To   : in Natural);
  -- Enable scrolling from row FROM to row TO.

  procedure Scroll_Down;
  -- Scroll display down one line.

  procedure Scroll_Down
    (Lines  : in Natural);
  -- Scroll display down by LINES lines.

  procedure Scroll_Up;
  -- Scroll display up one line.

  procedure Scroll_Up
    (Lines  : in Natural);
  -- Scroll display up by LINES lines.

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
