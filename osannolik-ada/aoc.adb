with Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO;

package body AOC is

   function "+" (P1, P2 : in Point) return Point
   is
   begin
      return Point'(X => P1.X + P2.X, Y => P1.Y + P2.Y);
   end "+";

   function Image (P : in Point) return String
   is
   begin
      return P.X'Img & "," & P.Y'Img;
   end Image;

   function Manhattan_Distance (P1 : in Point;
                                P2 : in Point := (0, 0))
                                return Natural
   is
   begin
      return abs (P1.X - P2.X) + abs (P1.Y - P2.Y);
   end Manhattan_Distance;

   function Max (IA    : in  Integer_Array;
                 Index : out Integer)
                 return Integer
   is
      Value : Integer;
   begin
      if IA'Length = 0 then
         raise Constraint_Error;
      end if;

      Index := IA'First;
      Value := IA (Index);
      
      for I in IA'First + 1 .. IA'Last loop
         if IA (I) > Value then
            Index := I;
            Value := IA (I);
         end if;
      end loop;

      return Value;
   end Max;
   
   function To_Integer_Array (IV : in V_Integer.Vector)
                              return Integer_Array
   is
      IA : Integer_Array (IV.First_Index .. IV.Last_Index);
      I : Integer := IV.First_Index;
   begin
      for Value of IV loop
         IA (I) := Value;
         I := Integer'Succ (I);
      end loop;

      return IA;
   end To_Integer_Array;

   function To_Integer_Array (SV : in V_String.Vector)
                              return Integer_Array
   is
   begin
      return To_Integer_Array (To_Integer_Vector (SV));
   end To_Integer_Array;

   function To_String_Array (SV : in V_String.Vector)
                             return String_Array
   is
      SA : String_Array (SV.First_Index .. SV.Last_Index);
      I : Integer := SV.First_Index;
   begin
      for Value of SV loop
         SA (I) := Value;
         I := Integer'Succ (I);
      end loop;

      return SA;
   end To_String_Array;

   function To_Integer_Vector (SV : in V_String.Vector)
                               return V_Integer.Vector
   is
      IV : V_Integer.Vector;
   begin
      for Value of SV loop
         IV.Append (Integer'Value (To_String (Value)));
      end loop;

      return IV;
   end To_Integer_Vector;

   procedure Split_String_At_Char (S       : in     String;
                                   Char    : in     Character;
                                   Strings : in out V_String.Vector)
   is
      Start : Integer := S'First;
   begin
      Strings.Clear;

      for I in S'Range loop
         if S (I) = Char then
            Strings.Append 
               (To_Unbounded_String (S (Start .. I - 1)));
            Start := I + 1;
         end if;
      end loop;

      Strings.Append (To_Unbounded_String (S (Start .. S'Last)));
   end Split_String_At_Char;

   procedure Get_File_Rows (V         : in out V_Integer.Vector;
                            File_Name : in     String)
   is
      use Ada.Text_IO;

      Input : File_Type;
   begin
      Open (File => Input,
            Mode => In_File,
            Name => File_Name);

      while not End_Of_File (Input) loop
         declare
            Row_Data : constant String := Get_Line (Input);
         begin
            V.Append (Integer'Value (Row_Data));
         end;
      end loop;

      Close (Input);

   exception
      when End_Error =>
         if Is_Open (Input) then
            Close (Input);
         end if;
   end Get_File_Rows;

   procedure Get_File_Rows (V         : in out V_String.Vector;
                            File_Name : in     String)
   is
      use Ada.Text_IO;

      Input : File_Type;
   begin
      Open (File => Input,
            Mode => In_File,
            Name => File_Name);

      while not End_Of_File (Input) loop
         V.Append (Ada.Strings.Unbounded.Text_IO.Get_Line (Input));
      end loop;

      Close (Input);

   exception
      when End_Error =>
         if Is_Open (Input) then
            Close (Input);
         end if;
   end Get_File_Rows;

   function Get_File_String (File_Name : in String)
                             return String
   is
      use Ada.Text_IO;

      Input : File_Type;
   begin
      Open (File => Input,
      	   Mode => In_File,
      	   Name => File_Name);

      declare
         --  Assume single line file...
         Content : constant String := Get_Line (Input);
      begin
         Close (Input);

         return Content;
      end;

   exception
      when End_Error =>
         if Is_Open(Input) then
            Close (Input);
         end if;

      return "";
   end Get_File_String;

   function To_Integer (C : in Character) 
                        return Integer
   is
   begin
      return Integer'Value (String' (1 => C));
   end To_Integer;

end AOC;