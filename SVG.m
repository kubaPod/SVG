(* Wolfram Language Package *)

BeginPackage["SVG`"]
  
  	ExportSVG;

Begin["`Private`"] (* Begin Private Context *) 


		(*List is included since we have to handle it separately too, more info later*)
	primitiveQ[expr_] := MemberQ[{Disk, List}, Head@expr] 
	
		(*list of directives that FE uses to render stuff when there is nothing but a primitive given by user*)
	defaultDirectives = {Black}
	
	
	ExportSVG[gr_Graphics]:= distributeDirectives @ First @ gr (*temp def till we finish*)
	
	
	
	
(*********************directives distribution***************************)


	distributeDirectives::usage:="dD[{graphics content}] returns {{directives.., primitive1}, {directives.., primitive2}}";
	
	distributeDirectives[graphicsContent_List] := First @ Last @ Reap @ splitAndAccumulate[
		Join[defaultDirectives, graphicsContent]
	];


		(* split part basically turns {Red, Disk[], Orange, Circle[]} 
		   into {{Red, Disk[]}, {Orange, Circle[]}} and passes it
		   to the accumulation procedure*)
	splitAndAccumulate = accumulate @ Split[#,  Not @ primitiveQ[#] &  ] &;


		(* the last element in each sublist is a primitive so we are accumulating Most of it *)
	accumulate = Rest @ FoldList[mergeDirectives @ Join[Most @ #, #2] &, {1}, #] &;


		(*TODO, Sow merged directives, not it Sows everything that was accumulated*)
	mergeDirectives[{previousDirs__, {nestedGraphics__}}] := {previousDirs, splitAndAccumulate@{previousDirs, nestedGraphics}};
	
	mergeDirectives[{previousDirs__, primitive_}] := {previousDirs,  Sow@{previousDirs, primitive}};
	
	
	
	
	
	
	

End[] (* End Private Context *)

EndPackage[]