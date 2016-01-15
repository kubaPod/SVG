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

BeginPackage["ExportSVG`"]
(* Exported symbols added here with SymbolName::usage *)

ExportSVG::usage = "";

Begin["`Private`"] (* Begin Private Context *)
Needs["ExportSVG`Parser`"]

SVG[data_, {{xmin_, xmax_}, {ymin_, ymax_}}] := XMLElement["svg", {
  "xmlns" -> "http://www.w3.org/2000/svg",
  "xmlns:xlink" -> "http://www.w3.org/1999/xlink",
  "width" -> StringTemplate["``pt"][348/1.25],
  "height" -> StringTemplate["``pt"][348/1.25],
  "viewBox" -> StringTemplate["`` `` `` ``"][xmin, ymin, xmax, ymax],
  "preserveAspectRatio" -> "xMinYMin meet"
}, data]

SVGDocument[data_] := XMLObject["Document"][{XMLObject["Declaration"]["Version" -> "1.0", "Encoding" -> "UTF-8"]}, data, {}]

getPlotRange[gr_Graphics] := PlotRange /. AbsoluteOptions[gr]

ExportSVG[gr_Graphics] := ExportString[SVGDocument[SVG[
  GraphicsToSVG[gr],
  getPlotRange[gr]
  ]], "XML"]

End[] (* End Private Context *)

EndPackage[]