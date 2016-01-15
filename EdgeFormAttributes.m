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

BeginPackage["ExportSVG`EdgeFormAttributes`"]
(* Exported symbols added here with SymbolName::usage *)

ConvertEdgeFormAttribute;

Begin["`Private`"] (* Begin Private Context *)
Needs["ExportSVG`DataTypes`"]

ConvertEdgeFormAttribute[attribute_?ColorQ] := "stroke" -> ConvertDataType[attribute]

End[] (* End Private Context *)

EndPackage[]