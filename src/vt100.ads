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
package VT100 is

  type Color is (Black, Red, Green, Yellow, Blue, Magenta, Cyan, White, Default);
  type Attribute is (Reset, Bold, Dim, Underline, Blink, Revers, Hidden);
  type Direction is (Up, Down, Forward, Backward);

  procedure Move_Cursor (Line, Column: Natural);
  procedure Clear_Screen;
  procedure Move_Cursor_Up (N: in Natural);
  procedure Move_Cursor_Down (N: in Natural);
  procedure Move_Cursor_Forward (N: in Natural);
  procedure Move_Cursor_Backward (N: in Natural);
  procedure Erase_Line;
  procedure Save_Cursor_Position;
  procedure Restore_Cursor_Position;
  procedure Set_Attribute (To: in Attribute);
  procedure Set_Foreground_Color (To: in Color);
  procedure Set_Background_Color (To: in Color);

end VT100;
