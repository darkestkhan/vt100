pragma License (GPL);
------------------------------------------------------------------------------
-- EMAIL: <darkestkhan@gmail.com>                                           --
-- License: GNU GPLv3 or any later as published by Free Software Foundation --
-- (see README file)                                                        --
--                    Copyright © 2011 darkestkhan                          --
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

  package ATIO renames Ada.Text_IO;
  package ASCII renames Ada.Characters.Latin_1;

  function Nat_Img (N: in Natural) return String
  is
    str: constant String := Natural'Image (N);
  begin
    return str (2 .. str'Last);
  end Nat_Img;

  procedure Move_Cursor (Line, Column: Natural)
  is
  begin
    ATIO.Put (ASCII.ESC & "[" & Nat_Img (Line) & ";" & Nat_Img (Column) & "H");
  end Move_Cursor;

  procedure Clear_Screen
  is
  begin
    ATIO.Put_Line (ASCII.ESC & "[2J");
  end Clear_Screen;

  procedure Move_Cursor_Up (N: in Natural)
  is
  begin
    if N > 0 then
      for I in 1 .. N loop
        ATIO.Put (ASCII.ESC & "[" & Nat_Img (N) & "A");
      end loop;
    end if;
  end Move_Cursor_Up;

  procedure Move_Cursor_Down (N: in Natural)
  is
  begin
    if N > 0 then
      for I in 1 .. N loop
        ATIO.Put (ASCII.ESC & "[" & Nat_Img (N) & "B");
      end loop;
    end if;
  end Move_Cursor_Down;

  procedure Move_Cursor_Forward (N: in Natural)
  is
  begin
    if N > 0 then
      for I in 1 .. N loop
        ATIO.Put (ASCII.ESC & "[" & Nat_Img (N) & "C");
      end loop;
    end if;
  end Move_Cursor_Forward;

  procedure Move_Cursor_Backward (N: in Natural)
  is
  begin
    if N > 0 then
      for I in 1 .. N loop
        ATIO.Put (ASCII.ESC & "[" & Nat_Img (N) & "D");
      end loop;
    end if;
  end Move_Cursor_Backward;

  procedure Erase_Line
  is
  begin
    ATIO.Put (ASCII.ESC & "[2K");
  end Erase_Line;

  procedure Save_Cursor_Position
  is
  begin
    ATIO.Put (ASCII.ESC & "[s");
  end Save_Cursor_Position;

  procedure Restore_Cursor_Position
  is
  begin
    ATIO.Put (ASCII.ESC & "[u");
  end Restore_Cursor_Position;

  procedure Set_Attribute (To: in Attribute)
  is
    C: Character;
  begin
    case To is
      when Reset => C := '0';
      when Bold => C := '1';
      when Dim => C := '2';
      when Underline => C := '3';
      when Blink => C := '4';
      when Revers => C := '5';
      when Hidden => C := '6';
    end case;
    ATIO.Put (ASCII.ESC & '[' & C & 'm');
  end Set_Attribute;

  procedure Set_Background_Color (To: in Color)
  is
    C: Character;
  begin
    case To is
      when Black => C := '0';
      when Red => C := '1';
      when Green => C := '2';
      when Yellow => C := '3';
      when Blue => C := '4';
      when Magenta => C := '5';
      when Cyan => C := '6';
      when White => C := '7';
      when Default => C := '9';
    end case;
    ATIO.Put (ASCII.ESC & "[4" & C & 'm');
  end Set_Background_Color;

  procedure Set_Foreground_Color (To: in Color)
  is
    C: Character;
  begin
    case To is
      when Black => C := '0';
      when Red => C := '1';
      when Green => C := '2';
      when Yellow => C := '3';
      when Blue => C := '4';
      when Magenta => C := '5';
      when Cyan => C := '6';
      when White => C := '7';
      when Default => C := '9';
    end case;
    ATIO.Put (ASCII.ESC & "[3" & C & 'm');
  end Set_Foreground_Color;

end VT100;
