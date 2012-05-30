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
--  - finish adding escape codes
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
    case Where is
      when Up =>
        if By > 0 then
          for I in 1 .. By loop
            Ada.Text_IO.Put
              (File => Ada.Text_IO.Standard_Error,
               Item => ASCII.ESC & "[" & Nat_Img (By) & "A");
          end loop;
        end if;
      when Down =>
        if By > 0 then
          for I in 1 .. By loop
            Ada.Text_IO.Put
              (File => Ada.Text_IO.Standard_Error,
               Item => ASCII.ESC & "[" & Nat_Img (By) & "B");
          end loop;
        end if;
      when Forward =>
        if By > 0 then
          for I in 1 .. By loop
            Ada.Text_IO.Put
              (File => Ada.Text_IO.Standard_Error,
               Item => ASCII.ESC & "[" & Nat_Img (By) & "C");
          end loop;
        end if;
      when Backward =>
        if By > 0 then
          for I in 1 .. By loop
            Ada.Text_IO.Put
              (File => Ada.Text_IO.Standard_Error,
               Item => ASCII.ESC & "[" & Nat_Img (By) & "D");
          end loop;
        end if;
    end case;
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

        -------------------------------
        -- S E T _ A T T R I B U T E --
        -------------------------------

  procedure Set_Attribute
    (This: in Attribute)
  is
    C: Character;
  begin
    case To is
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
    case To is
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
    case To is
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

end VT100;
