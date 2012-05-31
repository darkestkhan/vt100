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
-- TODO:
--  - finish adding escape codes [cursor controls]
with Ada.Text_IO;
with Ada.Characters.Latin_1;
package body VT100 is

        -------------------
        -- R E N A M E S --
        -------------------

  package ASCII renames Ada.Characters.Latin_1;

        -------------------
        -- N A T _ I M G --
        -------------------

  function Nat_Img
    (N: in Natural) return String
  is
    str: constant String := Natural'Image (N);
  begin
    return str (2 .. str'Last);
  end Nat_Img;

        ---------------
        -- R E S E T --
        ---------------

  procedure Reset
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "c");
  end Reset;

        -------------------------------
        -- L I N E _ W R A P P I N G --
        -------------------------------

  procedure Line_Wrapping
    (State  : in Boolean)
  is
  begin
    case State is
      when False =>
        Ada.Text_IO.Put
          (File => Ada.Text_IO.Standard_Output,
           Item => ASCII.ESC & "[7l");
      when True =>
        Ada.Text_IO.Put
          (File => Ada.Text_IO.Standard_Output,
           Item => ASCII.ESC & "[7h");
    end case;
  end Line_Wrapping;

        -------------------------------------
        -- U S E _ D E F A U L T _ F O N T --
        -------------------------------------

  procedure Use_Default_Font
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "(");
  end Use_Default_Font;

        -----------------------------------------
        -- U S E _ A L T E R N A T E _ F O N T --
        -----------------------------------------

  procedure Use_Alternate_Font
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & ")");
  end Use_Alternate_Font;

        -----------------------------
        -- C L E A R _ S C R E E N --
        -----------------------------

  procedure Clear_Screen
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[2J");
  end Clear_Screen;

        -------------------------
        -- E R A S E _ L I N E --
        -------------------------

  procedure Erase_Line
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[2K");
  end Erase_Line;

        ---------------
        -- E R A S E --
        ---------------

  procedure Erase
    (Where  : in Direction)
  is
  begin
    case Where is
      when Up       =>
        Ada.Text_IO.Put
          (File => Ada.Text_IO.Standard_Output,
           Item => ASCII.ESC & "[1J");
      when Down     =>
        Ada.Text_IO.Put
          (File => Ada.Text_IO.Standard_Output,
           Item => ASCII.ESC & "[J");
      when Forward  =>
        Ada.Text_IO.Put
          (File => Ada.Text_IO.Standard_Output,
           Item => ASCII.ESC & "[K");
      when Backward =>
        Ada.Text_IO.Put
          (File => Ada.Text_IO.Standard_Output,
           Item => ASCII.ESC & "[1K");
    end case;
  end Erase;

        ---------------------------
        -- M O V E _ C U R S O R --
        ---------------------------

  procedure Move_Cursor
    (Line   : in Natural;
     Column : in Natural)
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[" & Nat_Img (Line) & ";" & Nat_Img (Column) & "H");
  end Move_Cursor;

        ---------------------------
        -- M O V E _ C U R S O R --
        ---------------------------

  procedure Move_Cursor
    (Where : in Direction;
     By    : in Natural)
  is
  begin
    if By > 0 then
      case Where is
        when Up =>
          Ada.Text_IO.Put
            (File => Ada.Text_IO.Standard_Output,
             Item => ASCII.ESC & "[" & Nat_Img (By) & "A");
        when Down =>
          Ada.Text_IO.Put
            (File => Ada.Text_IO.Standard_Output,
             Item => ASCII.ESC & "[" & Nat_Img (By) & "B");
        when Forward =>
          Ada.Text_IO.Put
            (File => Ada.Text_IO.Standard_Output,
             Item => ASCII.ESC & "[" & Nat_Img (By) & "C");
        when Backward =>
          Ada.Text_IO.Put
            (File => Ada.Text_IO.Standard_Output,
             Item => ASCII.ESC & "[" & Nat_Img (By) & "D");
      end case;
    end if;
  end Move_Cursor;

        ---------------------------------------------
        -- S A V E _ C U R S O R _ P O S I T I O N --
        ---------------------------------------------

  procedure Save_Cursor_Position
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[s");
  end Save_Cursor_Position;

        ---------------------------------------------------
        -- R E S T O R E _ C U R S O R _ P O S I T I O N --
        ---------------------------------------------------

  procedure Restore_Cursor_Position
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[u");
  end Restore_Cursor_Position;

        -------------------
        -- S E T _ T A B --
        -------------------

  procedure Set_Tab
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "H");
  end Set_Tab;

        -----------------------
        -- C L E A R _ T A B --
        -----------------------

  procedure Clear_Tab
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[g");
  end Clear_Tab;

        ---------------------------------
        -- C L E A R _ A L L _ T A B S --
        ---------------------------------

  procedure Clear_All_Tabs
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[3g");
  end Clear_All_Tabs;

        -------------------------------
        -- S C R O L L _ S C R E E N --
        -------------------------------

  procedure Scroll_Screen
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[r");
  end Scroll_Screen;

        -------------------------------
        -- S C R O L L _ S C R E E N --
        -------------------------------

  procedure Scroll_Screen
    (From : in Natural;
     To   : in Natural)
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[" & Nat_Img (N => From) & ";" &
               Nat_Img (N => To) & "r");
  end Scroll_Screen;

        ---------------------------
        -- S C R O L L _ D O W N --
        ---------------------------

  procedure Scroll_Down
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "D");
  end Scroll_Down;

        ---------------------------
        -- S C R O L L _ D O W N --
        ---------------------------

  procedure Scroll_Down
    (Lines  : in Natural)
  is
  begin
    if Lines > 0 then
      for I in 1 .. Lines loop
        Scroll_Down;
      end loop;
    end if;
  end Scroll_Down;

        -----------------------
        -- S C R O L L _ U P --
        -----------------------

  procedure Scroll_Up
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "H");
  end Scroll_Up;

        -----------------------
        -- S C R O L L _ U P --
        -----------------------

  procedure Scroll_Up
    (Lines  : in Natural)
  is
  begin
    if Lines > 0 then
      for I in 1 .. Lines loop
        Scroll_Up;
      end loop;
    end if;
  end Scroll_Up;

        -------------------------------
        -- S E T _ A T T R I B U T E --
        -------------------------------

  procedure Set_Attribute
    (This: in Attribute)
  is
    C: Character;
  begin
    case This is
      when Reset      => C := '0';
      when Bold       => C := '1';
      when Dim        => C := '2';
      when Underline  => C := '3';
      when Blink      => C := '4';
      when Revers     => C := '5';
      when Hidden     => C := '6';
    end case;
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & '[' & C & 'm');
  end Set_Attribute;

        ---------------------------------------------
        -- S E T _ B A C K G R O U N D _ C O L O R --
        ---------------------------------------------

  procedure Set_Background_Color
    (This: in Color)
  is
    C: Character;
  begin
    case This is
      when Black    => C := '0';
      when Red      => C := '1';
      when Green    => C := '2';
      when Yellow   => C := '3';
      when Blue     => C := '4';
      when Magenta  => C := '5';
      when Cyan     => C := '6';
      when White    => C := '7';
      when Default  => C := '9';
    end case;
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[4" & C & 'm');
  end Set_Background_Color;

        ---------------------------------------------
        -- S E T _ F O R E G R O U N D _ C O L O R --
        ---------------------------------------------

  procedure Set_Foreground_Color
    (This: in Color)
  is
    C: Character;
  begin
    case This is
      when Black    => C := '0';
      when Red      => C := '1';
      when Green    => C := '2';
      when Yellow   => C := '3';
      when Blue     => C := '4';
      when Magenta  => C := '5';
      when Cyan     => C := '6';
      when White    => C := '7';
      when Default  => C := '9';
    end case;
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[3" & C & 'm');
  end Set_Foreground_Color;

        -----------------------------
        -- P R I N T _ S C R E E N --
        -----------------------------

  procedure Print_Screen
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[i");
  end Print_Screen;

        -------------------------
        -- P R I N T _ L I N E --
        -------------------------

  procedure Print_Line
  is
  begin
    Ada.Text_IO.Put
      (File => Ada.Text_IO.Standard_Output,
       Item => ASCII.ESC & "[1i");
  end Print_Line;

        -----------------------
        -- P R I N T _ L O G --
        -----------------------

  procedure Print_Log
    (State  : in Boolean)
  is
  begin
    case State is
      when False =>
        Ada.Text_IO.Put
          (File => Ada.Text_IO.Standard_Output,
           Item => ASCII.ESC & "[4i");
      when True =>
        Ada.Text_IO.Put
          (File => Ada.Text_IO.Standard_Output,
           Item => ASCII.ESC & "[5i");
    end case;
  end Print_Log;

end VT100;
