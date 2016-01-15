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

BeginPackage["ExportSVG`FaceFormAttributes`"]
(* Exported symbols added here with SymbolName::usage *)

ConvertFaceFormAttribute;

Begin["`Private`"] (* Begin Private Context *)
Needs["ExportSVG`DataTypes`"]

ConvertFaceFormAttribute[attribute_?ColorQ] := "fill" -> ConvertDataType[attribute]

End[] (* End Private Context *)

EndPackage[]