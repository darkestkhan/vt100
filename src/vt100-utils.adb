------------------------------------------------------------------------------
-- EMAIL: <darkestkhan@gmail.com>                                           --
-- License: ISC License (see COPYING file)                                  --
--                                                                          --
--                    Copyright © 2012 - 2015 darkestkhan                   --
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
with Ada.Environment_Variables;
package body VT100.Utils is

        ---------------
        -- L I N E S --
        ---------------

  function Lines return Natural
  is
  begin
    if Ada.Environment_Variables.Exists ("LINES") then
      return Natural'Value (Ada.Environment_Variables.Value (Name => "LINES"));
    else
      return 0;
    end if;
  end Lines;

        -------------------
        -- C O L U M N S --
        -------------------

  function Columns return Natural
  is
  begin
    if Ada.Environment_Variables.Exists ("COLUMNS") then
      return Natural'Value (Ada.Environment_Variables.Value
                              (Name => "COLUMNS"));
    else
      return 0;
    end if;
  end Columns;

end VT100.Utils;
