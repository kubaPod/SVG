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

BeginPackage["ExportSVG`Primitives`"]
(* Exported symbols added here with SymbolName::usage *)

ConvertPrimitive;

Begin["`Private`"] (* Begin Private Context *)

(* ------ Rectangle ------ *)
ConvertPrimitive[
  Rectangle[{xmin_, ymin_}, {xmax_, ymax_}, options : _Rule ...]] := <| (* Can't use OptionsPattern[] when nested? Better alternatives? *)
    "x" -> StringTrim[ToString[xmin],"."], (* SVG doesn't accept e.g. 1. as a number, has to be e.g. 1.0 *)
    "y" -> StringTrim[ToString[ymin],"."],
    "width" -> StringTrim[ToString[xmax - xmin],"."],
    "height" -> StringTrim[ToString[ymax - ymin],"."],
    "rx" -> StringTrim[ToString[RoundingRadius /. {options} /. RoundingRadius -> 0],"."],
    "ry" -> StringTrim[ToString[RoundingRadius /. {options} /. RoundingRadius -> 0],"."]
    |>

ConvertPrimitive[Rectangle[{xmin_, ymin_}, options : _Rule ...]] := ConvertPrimitive[Rectangle[{xmin, ymin}, {xmin + 1, ymin + 1}, options]]
ConvertPrimitive[Rectangle[options : _Rule ...]] := ConvertPrimitive[Rectangle[{0, 0}, options]]

(* ------ Circle ------ *)


(* ------ Disk ------ *)


(* ------ Polygon ------ *)


End[] (* End Private Context *)

EndPackage[]