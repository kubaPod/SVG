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

BeginPackage["ExportSVG`Parser`"]
(* Exported symbols added here with SymbolName::usage *)

GraphicsToSVG;

Begin["`Private`"] (* Begin Private Context *)
Needs["ExportSVG`Primitives`"]
Needs["ExportSVG`FaceFormAttributes`"]
Needs["ExportSVG`EdgeFormAttributes`"]

(* ------ XML rules ------ *)
SVGRectangle[attributes_Association] := XMLElement["rect", Normal[attributes], {}]
SVGCircle[attributes_Association] := XMLElement["circle", Normal[attributes], {}]
SVGEllipse[attributes_Association] := XMLElement["ellipse", Normal[attributes], {}]
SVGLine[attributes_Association] := XMLElement["line", Normal[attributes], {}]
SVGPolyline[attributes_Association] := XMLElement["polyline", Normal[attributes], {}]
SVGPolygon[attributes_Association] := XMLElement["polygon", Normal[attributes], {}]
SVGPath[attributes_Association] := XMLElement["path", Normal[attributes], {}]

SVGPrimitive[primitive_Rectangle, faceForm_, edgeForm_] := SVGRectangle[<|
    ConvertPrimitive[primitive],
    ConvertFaceFormAttribute /@ faceForm,
    ConvertEdgeFormAttribute /@ edgeForm
    |>]


(* ------ Pre-processing of graphics directives ------ *)
PreProcessGraphics[gr_] := gr /. {
  RGBColor[r_, g_, b_, a_] :> Sequence[RGBColor[r, g, b], Opacity[a]] (* Since opacity is a separate attribte in SVG *)
}

(* ------ Parse graphics directives ------ *)
primitiveQ[expr_] := MemberQ[{Disk, Rectangle, List}, Head@expr]
defaultDirectives = {Black};
distributeDirectives[graphicsContent_List] := splitAndAccumulate[Join[defaultDirectives, graphicsContent]];

splitAndAccumulate = accumulate@Split[#, Not@primitiveQ[#] &] &;

accumulate = Rest@FoldList[mergeDirectives@Join[Most@#, #2] &, {1}, #] &;

mergeDirectives[{previousDirs__, {nestedGraphics__}}] := {previousDirs, splitAndAccumulate@{previousDirs, nestedGraphics}}
mergeDirectives[{previousDirs__, primitive_}] := {previousDirs, Sow@{previousDirs, primitive}}

removeDuplicateAttributes[{a___, x_[___], b___, x_[y___], c___}] := removeDuplicateAttributes[{a, b, x[y], c}]
removeDuplicateAttributes[{a___, _?ColorQ, b___, x_?ColorQ, c___}] := removeDuplicateAttributes[{a, b, x, c}]
removeDuplicateAttributes[l : {___}] := l

categorizeAttributes[{attributes : ___, primitive_?primitiveQ}] := SVGPrimitive[
  primitive,
  removeDuplicateAttributes@Cases[{attributes} /. {FaceForm -> Sequence, Directive -> Sequence}, Except[_EdgeForm]],
  removeDuplicateAttributes@Cases[{attributes} /. {FaceForm -> Sequence, Directive -> Sequence}, EdgeForm[edgeForm__] :> edgeForm]
]

GraphicsToSVG[Graphics[directives_]] := Map[
  categorizeAttributes,
  Reap[distributeDirectives[PreProcessGraphics@directives]][[2, 1]]
]

End[] (* End Private Context *)

EndPackage[]