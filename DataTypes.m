(* Mathematica Package          *)
(* Created by IntelliJ IDEA     *)

(* :Title: ExportSVG            *)
(* :Context: ExportSVG`         *)
(* :Author: ...                 *)
(* :Date: 2016-01-15            *)

(* :Package Version: 1.0        *)
(* :Mathematica Version:        *)
(* :Copyright: (c) 2016 ...     *)
(* :Keywords:                   *)
(* :Discussion:                 *)

BeginPackage["ExportSVG`DataTypes`"]
(* Exported symbols added here with SymbolName::usage *)

ConvertDataType;

Begin["`Private`"] (* Begin Private Context *)

ConvertDataType[RGBColor[r_, g_, b_]] := StringTemplate["rgb(``%,``%,``%)"][100 r, 100 g, 100 b]
ConvertDataType[GrayLevel[gl_]] := ConvertColor[RGBColor[gl, gl, gl]]

End[] (* End Private Context *)

EndPackage[]